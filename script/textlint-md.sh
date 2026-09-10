#!/usr/bin/env bash
#
# Run textlint on Markdown files with the config that matches the document
# language. textlint has no per-file rule overrides, so the language is decided
# here and the matching config is passed with --config.
# See https://github.com/textlint/textlint/issues/709
#
# Usage:
#   script/textlint-md.sh [textlint options] <file>...
#
# Examples:
#   script/textlint-md.sh README.md
#   script/textlint-md.sh --fix docs/guide.md docs/guide_en.md
#
# Arguments that name an existing file are treated as targets, everything else
# is forwarded to textlint as an option.
#
# Language selection per file:
#   1. A path matching *_en.md, *.en.md or containing an "en" directory is English.
#   2. Otherwise the ratio of Japanese characters decides.

set -euo pipefail

# Location of the textlint configs and node_modules.
DOTFILES_DIR="${DOTFILES_DIR:-${HOME}/Git/dotfiles}"

# A document with a lower percentage of Japanese characters is linted as English.
JA_RATIO_THRESHOLD="${JA_RATIO_THRESHOLD:-5}"

# Options forwarded to textlint, filled by parse_arguments.
TEXTLINT_OPTIONS=()

# Absolute paths of the files to lint, filled by parse_arguments.
TARGET_FILES=()

usage() {
  cat <<'USAGE'
Run textlint with the config matching each document's language.

Usage:
  script/textlint-md.sh [textlint options] <file>...

Environment variables:
  DOTFILES_DIR         Directory holding .textlintrc.{ja,en}.json (default: ~/Git/dotfiles)
  JA_RATIO_THRESHOLD   Japanese character percentage to treat a file as Japanese (default: 5)
USAGE
}

parse_arguments() {
  local argument

  for argument in "$@"; do
    if [[ -f ${argument} ]]; then
      TARGET_FILES+=("$(realpath "${argument}")")
    else
      TEXTLINT_OPTIONS+=("${argument}")
    fi
  done
}

# Print "ja" or "en" for the given file.
detect_language() {
  local file=$1

  # An explicit naming convention wins over content based detection.
  case ${file} in
  *_en.md | *.en.md | */en/*)
    echo "en"
    return
    ;;
  esac

  TEXTLINT_MD_FILE="${file}" TEXTLINT_MD_THRESHOLD="${JA_RATIO_THRESHOLD}" node <<'NODE'
const fs = require("node:fs");

// Fenced code blocks are not proofread by textlint but would skew the ratio of
// a code heavy Japanese document towards English, so drop them first.
const prose = fs
  .readFileSync(process.env.TEXTLINT_MD_FILE, "utf8")
  .replace(/^```[\s\S]*?^```/gm, "");

const japaneseCharacters = prose.match(/[\u3040-\u30ff\u3400-\u4dbf\u4e00-\u9fff]/gu) ?? [];
const visibleCharacters = prose.match(/\S/gu) ?? [];
const ratio =
  visibleCharacters.length === 0
    ? 0
    : (japaneseCharacters.length / visibleCharacters.length) * 100;

process.stdout.write(ratio >= Number(process.env.TEXTLINT_MD_THRESHOLD) ? "ja" : "en");
NODE
}

run_textlint() {
  local language=$1
  shift
  local config="${DOTFILES_DIR}/.textlintrc.${language}.json"

  if [[ ! -f ${config} ]]; then
    echo "textlint-md: config not found: ${config}" >&2
    return 1
  fi

  # textlint resolves rule packages relative to the working directory, so it has
  # to run inside the dotfiles workspace where node_modules lives.
  (
    cd "${DOTFILES_DIR}" &&
      npx textlint --config "${config}" ${TEXTLINT_OPTIONS[@]+"${TEXTLINT_OPTIONS[@]}"} "$@"
  )
}

main() {
  if [[ $# -eq 0 ]]; then
    usage
    exit 1
  fi

  parse_arguments "$@"

  if [[ ${#TARGET_FILES[@]} -eq 0 ]]; then
    echo "textlint-md: no existing file given" >&2
    usage
    exit 1
  fi

  local japanese_files=()
  local english_files=()
  local file

  for file in "${TARGET_FILES[@]}"; do
    if [[ $(detect_language "${file}") == "ja" ]]; then
      japanese_files+=("${file}")
    else
      english_files+=("${file}")
    fi
  done

  # Keep linting both groups even if the first one reports problems, then
  # surface the failure so callers such as Kiro hooks and CI can react.
  local status=0

  if [[ ${#japanese_files[@]} -gt 0 ]]; then
    run_textlint ja "${japanese_files[@]}" || status=$?
  fi

  if [[ ${#english_files[@]} -gt 0 ]]; then
    run_textlint en "${english_files[@]}" || status=$?
  fi

  return "${status}"
}

main "$@"
