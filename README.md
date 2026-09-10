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

Then add the rule configuration to the config for the language the rule targets (see [Config per language](#config-per-language)) and commit [`package.json`](package.json), `package-lock.json`, and the config you changed.

### Removing a package

```bash
cd "$DOTFILES_DIR"
npm uninstall <package-name>
```

Then remove the rule configuration from the config files and commit the changes.

### Config per language

textlint cannot switch rules per file, so there is one config per language.

| File | Purpose |
| --- | --- |
| [`.textlintrc.ja.json`](.textlintrc.ja.json) | Japanese documents |
| [`.textlintrc.en.json`](.textlintrc.en.json) | English documents |

Both configs share a block of language independent rules. textlint has no `extends`, so the block is duplicated and has to be kept in sync by hand.

Rules that only make sense for one language stay in that config. `spellcheck-tech-word` is the clearest example: with `--fix` it rewrites English words into katakana, so it is disabled for English. `write-good` is the reverse and reports warnings instead of errors, because its suggestions need human judgement.

### Running textlint

Use [`script/textlint-md.sh`](script/textlint-md.sh). It picks the config per file and runs textlint from this directory so that rule packages resolve.

```bash
./script/textlint-md.sh --fix path/to/file.md
```

A file is treated as English when its path matches `*_en.md`, `*.en.md` or contains an `en` directory. Otherwise the ratio of Japanese characters decides, ignoring fenced code blocks.

`script/npm.sh install` also links `.textlintrc.ja.json` to `.textlintrc.json` in the Git workspace root. That link exists for the textlint editor extension, which discovers a single config and cannot switch per file.

### Syncing on another machine

Run `make install` or `./script/npm.sh install`. `mise deps` will detect changes in `package-lock.json` and run `npm install` automatically.

Enjoy for dotfiles management !
