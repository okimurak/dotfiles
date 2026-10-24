# dotfiles リポジトリ概要

## プロジェクト構成

このリポジトリは Linux / macOS の開発環境を管理する dotfiles リポジトリ。Windows は非対応のため、Windows 環境では WSL2 経由で使用する。

### ディレクトリ構造

- `/` : dotfiles 本体（`.zshrc`, `.zshenv`, `.gitconfig_shared` 等）
- `script/` : セットアップ・アンインストールスクリプト群（シェルスクリプト）
- `git/` : Git 用グローバル設定（ignore ファイル）
- `.zsh/completion/` : zsh 補完ファイル
- `.windows_commands/` : WSL2 から利用する Windows コマンドへのシンボリックリンク

### 主要コンポーネント

- **パッケージ管理**: [mise](https://github.com/jdx/mise) で CLI ツールを一元管理（`config.toml`）
- **シェル**: zsh + [Starship](https://starship.rs/) プロンプト（`starship.toml`）
- **Linter / Formatter**: textlint, markdownlint-cli2, Biome, Prettier（mise 経由で管理）
- **セットアップ**: `Makefile` でインストール/アンインストール/アップデートを管理

### textlint の設定構成

textlint はファイルごとにルールを切り替える機能を持たないため、言語ごとに config を分けている。

- `.textlintrc.ja.json` : 日本語文書用
- `.textlintrc.en.json` : 英語文書用
- `script/textlint-md.sh` : 文書の言語を判定して config を選び、textlint を実行するラッパー

Markdown の lint はこのラッパー経由で実行する。

```bash
./script/textlint-md.sh --fix path/to/file.md
```

エージェントから実行する場合は `markdown-lint` スキルを使う。`--fix` を打って良い条件や、error と warning の扱いの違いをスキル側に集約している。

言語判定はパスが `*_en.md`, `*.en.md`, `en/` 配下のいずれかに一致すれば英語、それ以外は日本語文字の比率で決める。比率の計算ではコードブロックを除外する。

両 config の先頭には言語非依存のルールを共通ブロックとして持つ。textlint に `extends` がないため重複しており、片方を変更したらもう片方も合わせて更新する。

言語固有のルールはその言語の config にのみ置く。

- `spellcheck-tech-word` : 英語では無効。`--fix` で英単語をカタカナに書き換えてしまう
- `write-good` : 英語のみ有効。指摘は人間の判断が必要なため severity を `warning` にして exit status を 0 に保つ

`script/npm.sh install` は `.textlintrc.ja.json` を `.textlintrc.json` として Git ワークスペース直下にシンボリックリンクする。これはエディタの textlint 拡張向けで、拡張は config を 1 つしか探索できないため日本語用をデフォルトにしている。

### セットアップフロー

```
make install
  → script/zsh.sh install      # zsh インストール + デフォルトシェル変更
  → script/mise.sh install     # mise + 各種ツールインストール
  → script/git.sh install      # git ignore のシンボリックリンク
  → script/npm.sh install      # linter 設定ファイルのシンボリックリンク
  → script/completer.sh install # zsh 補完ファイル取得
  → dotfiles を $HOME にシンボリックリンク
```

## 利用ツール（config.toml で管理）

- AWS 関連: aws-cli, aws-copilot, aws-sam, eksctl, rain, cfn-lint
- コンテナ/K8s: kubectl, kubectx, helm, ctop, lazydocker, stern
- 言語: node, python, golang
- ユーティリティ: jq, yq, peco, eza, starship, uv, shellcheck, shfmt, terraform, ffmpeg, gh

## ツール管理のルール

このリポジトリではすべての CLI ツール・言語ランタイム・npm/pip パッケージを **mise**（`config.toml`）で一元管理する。

- 新しいツールを追加する場合は `config.toml` の `[tools]` セクションに追記し、`mise install` で導入する
- npm パッケージは `"npm:パッケージ名" = { version = "x.y.z", depends = ["node"] }` 形式で管理する（`npm install -g` は使わない）
- pip パッケージは `"pipx:パッケージ名" = { version = "x.y.z", depends = ["python"] }` 形式で管理する
- GitHub リリースのバイナリは `"ubi:owner/repo"` や `"aqua:owner/repo"` 形式で管理する
- バージョンは必ず固定する（latest や範囲指定は使わない）
- ツールの追加・削除・バージョン変更を行った場合は、このステアリングファイル（`dotfiles-overview.md`）と `README.md` の該当箇所も合わせて更新する

## 対応 OS

- Linux（Ubuntu, Amazon Linux 等）
- macOS（Homebrew）
- Windows は非対応。WSL2 上の Linux ディストリビューションで使用する
