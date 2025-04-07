# dotfiles

Setup dotfiles and each tool settings on [mise](https://github.com/jdx/mise) and [Homebrew](https://docs.brew.sh/).

## Requirement

- Linux

## Install

Clone this repository

```bash
git clone https://github.com/okimurak/dotfiles.git
```

Create gitconfig (Replace `username` and `email`). If you should set work settings for Git, see [working settings](#git).

```bash
cat << EOF  > .gitconfig
[user]
  name = <user name>
  email = <email>
[include]
  path = ~/.gitconfig_shared
EOF
```

Run the following command.

```bash
make install
```

### Install Font

Please install the following font for your environment.

- [DejaVu Sans Mono](https://ja.fonts2u.com/download/dejavu-sans-mono.%E3%83%95%E3%82%A9%E3%83%B3%E3%83%88)
- [MesloLGS NF Regular.ttf](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf)
- [MesloLGS NF Bold.ttf](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf)
- [MesloLGS NF Italic.ttf](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf)
- [MesloLGS NF Bold Italic.ttf](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf)

Enjoy for dotfiles management.

### Install Tool

```bash
make install-tool
```

### WSL configure

```bash
make install-wsl
```

## Uninstall

Run the following command.

```bash
make clean
```

### Tool

```bash
make clean-tool
```

### WSL

```bash
make clean-wsl
```

## Update

```bash
make update
```

## Constitution

### Package Manager

- [mise](https://github.com/jdx/mise)
  - About install package, please see [config.toml by mise](config.toml).
  - If you want to use specific tool version, please create and use `.mise.toml` (please see [Configuration](https://mise.jdx.dev/configuration.html)).
- [Homebrew](https://docs.brew.sh/)
  - About install package, please see [.Brewfile by HomeBrew](.Brewfile)

### Shell

- zsh with [Starship](https://starship.rs/)

### Tools

- Git
- Linter
  - [textlint](https://github.com/textlint/textlint) plugins
  - [markdownlint](https://github.com/DavidAnson/markdownlint)
  - [Biome](https://biomejs.dev/ja/)
- [peco](https://github.com/peco/peco)
  - You can search command history by `Ctrl + R`.
- Python
  - [uv](https://github.com/astral-sh/uv)
    - If you develop python project, you can use uv to manage python package.

## Work settings

If you need setting for work setting, you can add setting or files for work setting.

### Git

Create gitconfig for work (`gitconfig_work`), if need.

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

### zsh

You can create or edit `.zshrc_work` to use work settings.
