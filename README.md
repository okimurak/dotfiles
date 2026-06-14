# dotfiles

Setup dotfiles and each tool settings on [mise](https://github.com/jdx/mise).

## Requirement

- Linux
- Git

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

Run the following command.

```bash
make install-font
```

Using [Moralerspace](https://github.com/yuru7/moralerspace)

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
- npm ([`package.json`](package.json))
  - textlint and its plugins are managed via `package.json` and installed with `mise deps`.
  - See [Managing textlint packages](#managing-textlint-packages) for details.

### Shell

- zsh with [Starship](https://starship.rs/)

### Tools

- Git
- Linter / Formatter
  - [textlint](https://github.com/textlint/textlint) plugins
  - [markdownlint](https://github.com/DavidAnson/markdownlint)
  - [Biome](https://biomejs.dev/ja/)
  - [Prettier](https://prettier.io/) : YAML / JSON formatter
- [peco](https://github.com/peco/peco) : You can search command history by `Ctrl + R`.
- Python
  - [uv](https://github.com/astral-sh/uv) : You can use uv to manage Python package if you develop Python project. Also you can execute tools created Python package like as [`AWS MCP Servers`](https://awslabs.github.io/mcp/), `cfn-lint` etc... without install.

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

## Managing textlint packages

textlint and its rule plugins are managed via [`package.json`](package.json) and installed with [`mise deps`](https://mise.jdx.dev/dev-tools/deps.html) (experimental).

### Adding a package

```bash
cd "$DOTFILES_DIR"
npm install --save-dev <package-name>@<version>
```

Example:

```bash
npm install --save-dev textlint-rule-prefer-tari-tari@1.0.2
```

Then add the rule configuration to [`.textlintrc`](.textlintrc) and commit [`package.json`](package.json), `package-lock.json`, and `.textlintrc`.

### Removing a package

```bash
cd "$DOTFILES_DIR"
npm uninstall <package-name>
```

Then remove the rule configuration from [`.textlintrc`](.textlintrc) and commit the changes.

### Syncing on another machine

Run `make install` or `./script/npm.sh install`. `mise deps` will detect changes in `package-lock.json` and run `npm install` automatically.

Enjoy for dotfiles management !
