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

- Create gitconfig for work, if need. (gitconfig_work)
  - Use it when you want to separate Git accounts
  - Set gitconfig as follows.

```bash
cat << EOF  > .gitconfig
[user]
  name = <user name>
  email = <email>
[includeIf "gitdir:~/path/to/working/dir"]
  path = ~/.gitconfig_work
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

- [DejaVu Sans Mono](https://ja.fonts2u.com/download/dejavu-sans-mono.%E3%83%95%E3%82%A9%E3%83%B3%E3%83%88)
- [MesloLGS NF Regular.ttf](
    https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf)
- [MesloLGS NF Bold.ttf](
    https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf)
- [MesloLGS NF Italic.ttf](
    https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf)
- [MesloLGS NF Bold Italic.ttf](
    https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf)

- Enjoy for dotfiles management.

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
- [Homebrew](https://docs.brew.sh/)
- Git

### Tools

- [ctop](https://github.com/bcicen/ctop) (from docker)
- Go
- node
  - textlint plugins
  - markdownlint
- Python
- Other
  - See [To Brew Shell](./tool/install_tool_to_brew.sh)
