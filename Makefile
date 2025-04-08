.PHONY: default install* clean*

CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .git .markdownlint.jsonc .textlintrc
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

default: update

install: install-dotfile install-tool install-completer

install-completer:
	./script/completer.sh install

install-dotfile:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

install-tool:
	./script/brew.sh install
	./script/zsh.sh install
	./script/mise.sh install
	./script/git.sh install
	./script/npm.sh install
	./script/completer.sh install

install-wsl:
	./script/wsl.sh

clean: clean-tool clean-dotfile

clean-dotfile:
	@$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)

clean-tool:
	./script/npm.sh uninstall
	./script/git.sh uninstall
	./script/mise.sh uninstall
	./script/zsh.sh uninstall
	./script/brew.sh uninstall

clean-wsl:
	./script/wsl.sh

update: update-dotfile update-tool

update-dotfile: clean-dotfile install-dotfile

update-tool:
	./script/brew.sh update
	./script/npm.sh update
	./script/mise.sh update
