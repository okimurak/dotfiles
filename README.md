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
  - About install package, please see [.tool-versions by mise](.tool-versions).
- [Homebrew](https://docs.brew.sh/)
  - About install package, please see [.Brewfile by HomeBrew](.Brewfile)

### Shell

- zsh
  - [Starship](https://starship.rs/)

### Tools

- Git
- [Node.js](https://nodejs.org/ja/)
  - textlint plugins
  - [markdownlint](https://github.com/DavidAnson/markdownlint)
- [peco](https://github.com/peco/peco)
  - You can search command history by `Ctrl + R`.
- Python (asdf-plugin used by [pyenv](https://github.com/pyenv/pyenv))
  - [Pipenv: 人間のためのPython開発ワークフロー — pipenv 2018.11.27.dev0 ドキュメント](https://pipenv-ja.readthedocs.io/ja/translate-ja/)

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
