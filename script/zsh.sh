#!/bin/bash

set -e

# Functions for colored messages
print_info() {
    echo -e "\033[34m[INFO]\033[0m $1"
}

print_success() {
    echo -e "\033[32m[SUCCESS]\033[0m $1"
}

print_error() {
    echo -e "\033[31m[ERROR]\033[0m $1"
}

print_warning() {
    echo -e "\033[33m[WARNING]\033[0m $1"
}

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ -f /etc/os-release ]]; then
        . /etc/os-release
        case $ID in
            ubuntu)
                echo "ubuntu"
                ;;
            amzn)
                echo "amazon_linux"
                ;;
            *)
                echo "unknown"
                ;;
        esac
    else
        echo "unknown"
    fi
}

# Check if zsh is installed
is_zsh_installed() {
    if command -v zsh >/dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

# Check if zsh is the default shell
is_zsh_default_shell() {
    if [[ "$SHELL" == *"zsh"* ]]; then
        return 0
    else
        return 1
    fi
}

# Install zsh using package manager
install_zsh_package() {
    local os=$1
    
    case $os in
        macos)
            if ! command -v brew >/dev/null 2>&1; then
                print_error "Homebrew is not installed. Please install Homebrew first."
                exit 1
            fi
            print_info "Installing zsh using Homebrew..."
            brew install zsh
            ;;
        ubuntu)
            print_info "Installing zsh using apt..."
            sudo apt update
            sudo apt install -y zsh
            ;;
        amazon_linux)
            print_info "Installing zsh using yum..."
            sudo yum install -y zsh
            ;;
        *)
            print_error "Unsupported OS: $os"
            exit 1
            ;;
    esac
}

install_zsh_configuration_files() {
  # Change default shell
  command -v zsh | sudo tee -a /etc/shells
  sudo chsh -s "$(which zsh)"
  configuration_path=$(pwd)/$(dirname $0)

  mkdir -p "${HOME}/.config" && ln -snf "${configuration_path}/starship.toml" "${HOME}/.config/starship.toml"
  # Install zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-autosuggestions "${configuration_path}/.zsh/zsh-autosuggestions"
}


# Uninstall zsh using package manager
uninstall_zsh_package() {
    local os=$1
    
    case $os in
        macos)
            if ! command -v brew >/dev/null 2>&1; then
                print_error "Homebrew is not installed."
                exit 1
            fi
            print_info "Uninstalling zsh using Homebrew..."
            brew uninstall zsh
            ;;
        ubuntu)
            print_info "Uninstalling zsh using apt..."
            sudo apt remove -y zsh
            sudo apt autoremove -y
            ;;
        amazon_linux)
            print_info "Uninstalling zsh using yum..."
            sudo yum remove -y zsh
            ;;
        *)
            print_error "Unsupported OS: $os"
            exit 1
            ;;
    esac
}

uninstall_zsh_configuration_files() {
  # Remove starship file
  unlink "${HOME}/.config/starship.toml"
  # Uninstall zsh-autosuggestions
  unlink "${HOME}/.zsh/zsh-autosuggestions"
  configuration_path=$(pwd)/$(dirname $0)
  rm -rf "${configuration_path}/.zsh/zsh-autosuggestions"
}

# Change default shell to zsh
change_default_shell_to_zsh() {
    local zsh_path
    zsh_path=$(which zsh)
    
    if [[ -z "$zsh_path" ]]; then
        print_error "zsh path not found"
        exit 1
    fi
    
    # Check if zsh path is registered in /etc/shells
    if ! grep -q "$zsh_path" /etc/shells; then
        print_info "Adding zsh to /etc/shells..."
        echo "$zsh_path" | sudo tee -a /etc/shells
    fi
    
    # Change default shell
    print_info "Changing default shell to zsh..."
    chsh -s "$zsh_path"
    print_success "Default shell changed to zsh. Please restart your terminal or run 'exec zsh' to use zsh."
}

# Change default shell back to bash
change_default_shell_to_bash() {
    local bash_path
    bash_path=$(which bash)
    
    if [[ -z "$bash_path" ]]; then
        print_error "bash path not found"
        exit 1
    fi
    
    print_info "Changing default shell back to bash..."
    chsh -s "$bash_path"
    print_success "Default shell changed back to bash."
}

# Install zsh
install_zsh() {
    local os
    os=$(detect_os)
    
    print_info "Detected OS: $os"
    
    # Check if already installed
    if is_zsh_installed; then
        print_warning "zsh is already installed."
        
        # Suggest changing default shell if not zsh
        if ! is_zsh_default_shell; then
            print_info "zsh is not the default shell. Changing default shell to zsh..."
            change_default_shell_to_zsh
        else
            print_info "zsh is already the default shell."
        fi
        return 0
    fi
    
    # Install zsh
    install_zsh_package "$os"
    
    # Check if installation succeeded
    if is_zsh_installed; then
        print_success "zsh installation completed successfully."
        
        # Change default shell to zsh
        change_default_shell_to_zsh
        # Add zsh configuration files
        install_zsh_configuration_files
    else
        print_error "zsh installation failed."
        exit 1
    fi
}

# Uninstall zsh
uninstall_zsh() {
    local os
    os=$(detect_os)
    
    print_info "Detected OS: $os"
    
    # Check if installed
    if ! is_zsh_installed; then
        print_warning "zsh is not installed."
        return 0
    fi
    
    # Warn if zsh is the default shell
    if is_zsh_default_shell; then
        print_warning "zsh is currently the default shell. Changing back to bash..."
        change_default_shell_to_bash
    fi
    
    # Uninstall zsh
    uninstall_zsh_package "$os"
    
    # Check if uninstallation succeeded
    if ! is_zsh_installed; then
        print_success "zsh uninstallation completed successfully."
    else
        print_error "zsh uninstallation failed."
        exit 1
    fi
}

# Show usage
show_usage() {
    echo "Usage: $0 {install|uninstall}"
    echo ""
    echo "Commands:"
    echo "  install    - Install zsh and set it as default shell"
    echo "  uninstall  - Uninstall zsh and change default shell back to bash"
    echo ""
    echo "Supported OS:"
    echo "  - macOS (using Homebrew)"
    echo "  - Ubuntu (using apt)"
    echo "  - Amazon Linux 2 (using yum)"
}

# Main
main() {
    if [[ $# -eq 0 ]]; then
        show_usage
        exit 1
    fi
    
    case $1 in
        install)
            install_zsh
            ;;
        uninstall)
            uninstall_zsh
            ;;
        -h|--help|help)
            show_usage
            ;;
        *)
            print_error "Unknown command: $1"
            show_usage
            exit 1
            ;;
    esac
}

# Call main function only when script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
