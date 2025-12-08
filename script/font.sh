#!/usr/bin/env zsh

# Moralerspace font installation script
# Supported environments: macOS, WSL2 (Ubuntu Distribution)

FONT_NAME="Moralerspace"
GITHUB_REPO="yuru7/moralerspace"
TEMP_DIR="/tmp/moralerspace_install"

# Detect OS
detect_os() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "macos"
  elif grep -qi microsoft /proc/version 2>/dev/null; then
    echo "wsl"
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "linux"
  else
    echo "unknown"
  fi
}

get_latest_release_url() {
  local api_url="https://api.github.com/repos/${GITHUB_REPO}/releases/latest"
  # Get URL matching Moralerspace_v*.zip pattern
  local download_url=$(curl -s "$api_url" | grep "browser_download_url" | grep -o 'https://[^"]*Moralerspace_v[0-9.]*\.zip' | head -n 1)
  
  if [[ -z "$download_url" ]]; then
    echo "Error: Failed to get Moralerspace_v*.zip URL" >&2
    return 1
  fi
  
  echo "$download_url"
}

install_macos() {
  echo "Installing fonts to macOS..."
  
  local font_dir="$HOME/Library/Fonts"
  mkdir -p "$font_dir"
  
  # Copy TTF files
  find "$TEMP_DIR" -name "*.ttf" -exec cp {} "$font_dir/" \;
  
  echo "✓ Fonts installed to $font_dir"
}

install_wsl() {
  echo "Installing fonts to WSL2 (Ubuntu)..."
  
  local font_dir="$HOME/.local/share/fonts"
  mkdir -p "$font_dir"
  
  # Copy TTF files
  find "$TEMP_DIR" -name "*.ttf" -exec cp {} "$font_dir/" \;
  
  # Update font cache
  fc-cache -fv
  
  echo "✓ Fonts installed to $font_dir"
}

download_and_extract() {
  echo "Downloading latest ${FONT_NAME}..."
  
  local download_url=$(get_latest_release_url)
  if [[ $? -ne 0 ]]; then
    return 1
  fi
  
  echo "Download URL: $download_url"
  
  # Prepare temporary directory
  rm -rf "$TEMP_DIR"
  mkdir -p "$TEMP_DIR"
  
  # Download
  local zip_file="$TEMP_DIR/moralerspace.zip"
  curl -L -o "$zip_file" "$download_url"
  
  if [[ $? -ne 0 ]]; then
    echo "Error: Download failed" >&2
    return 1
  fi
  
  # Extract
  echo "Extracting files..."
  unzip -q "$zip_file" -d "$TEMP_DIR"
  
  if [[ $? -ne 0 ]]; then
    echo "Error: Extraction failed" >&2
    return 1
  fi
  
  echo "✓ Download and extraction completed"
}

install() {
  local os_type=$(detect_os)
  
  echo "Detected OS: $os_type"
  
  if [[ "$os_type" == "unknown" ]]; then
    echo "Error: Unsupported OS" >&2
    return 1
  fi
  
  # Download and extract
  download_and_extract
  if [[ $? -ne 0 ]]; then
    return 1
  fi
  
  # Install based on OS
  case "$os_type" in
    macos)
      install_macos
      ;;
    wsl)
      install_wsl
      ;;
    linux)
      install_wsl  # Use same method as WSL for Linux
      ;;
  esac
  
  # Cleanup
  rm -rf "$TEMP_DIR"
  
  echo ""
  echo "✓ ${FONT_NAME} installation completed!"
  echo "  Please restart your terminal or editor to use the fonts."
}

uninstall() {
  local os_type=$(detect_os)
  
  echo "Uninstalling ${FONT_NAME}..."
  
  case "$os_type" in
    macos)
      local font_dir="$HOME/Library/Fonts"
      find "$font_dir" -name "*Moralerspace*.ttf" -delete
      echo "✓ Fonts removed from macOS"
      ;;
    wsl|linux)
      local font_dir="$HOME/.local/share/fonts"
      find "$font_dir" -name "*Moralerspace*.ttf" -delete
      fc-cache -fv
      echo "✓ Fonts removed from Linux"
      ;;
  esac
}

# Usage
usage() {
  cat <<EOF
$0
  Moralerspace font installation script
  Supported environments: macOS, WSL2 (Ubuntu 24 LTS)

Usage:
  install     : Install fonts
  uninstall   : Uninstall fonts
  help        : Show this help

Examples:
  $0 install
  $0 uninstall
EOF
}

# Main
main() {
  local cmd=$1
  
  case "$cmd" in
    install)
      install
      ;;
    uninstall)
      uninstall
      ;;
    help|--help|-h)
      usage
      ;;
    *)
      usage
      ;;
  esac
}

main "$@"
