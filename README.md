# dotfiles

Setup dotfiles on Homebrew.

## Requirement

- Linux

## Install

- Clone this repository

```bash
git clone https://github.com/okimurak/dotfiles_mac.git
```

- Create gitconfig (Inplace `username` and `email`)

```bash
cat << EOF  > .gitconfig
[user]
  name = <user name>
  email = <email>
[include]
  path = ~/.gitconfig_shared
EOF
```

- Install

Run the following command.

```bash
.bin/install.sh
```

- Install Font

Please install the following font for your environment.

- [MesloLGS NF Regular.ttf](
    https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf)
- [MesloLGS NF Bold.ttf](
    https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf)
- [MesloLGS NF Italic.ttf](
    https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf)
- [MesloLGS NF Bold Italic.ttf](
    https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf)

- Enjoy for doffile managements !

## Install Tool

```bash
./tool/install_tool.sh
```

## Uninstall

Run the following command.

```bash
.bin/uninstall.sh
```

## Components


### Main

- zsh
  - Prezto
    - Theme : [romkatv/powerlevel10](https://github.com/romkatv/powerlevel10)
- [HomeBrew](https://docs.brew.sh/)
- Git

### Tools

- [AWS CLI v2](https://docs.aws.amazon.com/cli/index.html) (from docker)
- [ctop](https://github.com/bcicen/ctop) (from docker)
- Go
- node
- markdownlint
- Python
- Other
  - See [To Brew Shell](./tool/install_tool_to_brew.sh)
