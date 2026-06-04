.PHONY: default install* clean*

CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .git .markdownlint.jsonc .textlintrc
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

default: update

# Run install-dotfile twice: first to create symlinks needed by install-tool/install-completer
# (mise.sh requires $HOME/.zshrc for mise activate), then again to pick up generated dotfiles.
install:
	$(MAKE) install-dotfile
	$(MAKE) install-tool
	$(MAKE) install-completer
	$(MAKE) install-dotfile

install-completer:
	./script/completer.sh install

install-dotfile:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

install-tool:
	./script/zsh.sh install
	./script/mise.sh install
	./script/git.sh install
	./script/npm.sh install

install-font:
	./script/font.sh install

install-wsl:
	./script/wsl.sh install

clean: clean-tool clean-dotfile

clean-dotfile:
	@$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)

clean-tool:
	./script/npm.sh uninstall
	./script/git.sh uninstall
	./script/mise.sh uninstall
	./script/zsh.sh uninstall

clean-font:
	./script/font.sh uninstall

clean-wsl:
	./script/wsl.sh uninstall

update: update-dotfile update-tool

update-dotfile: clean-dotfile install-dotfile

update-tool:
	./script/mise.sh update
