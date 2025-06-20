#!/usr/bin/env bash

install() {

  if [[ ! -f "/etc/wsl.conf" ]];then
    sudo cat <<EOF > /etc/wsl.conf
[interop]
appendWindowsPath = false
EOF
  fi
  
  if [[ ! -d "${configure_path}" ]]; then
    mkdir -p "${configure_path}"
  fi
  cd ${configure_path} || exit

  local SystemMountPath="/mnt/c"

  # certutil
  ln -s "${SystemMountPath}/Windows/System32/certutil.exe" .
  # clip
  ln -s "${SystemMountPath}/Windows/System32/clip.exe" .
  # Docker Desktop for Windows
  ln -s "${SystemMountPath}/Program Files/Docker/Docker/resources/bin/docker-credential-desktop.exe" .
  # PowerShell
  ln -s "${SystemMountPath}/Windows/System32/WindowsPowerShell/v1.0/powershell.exe" .
}

uninstall() {
  rm -rf "${configure_path}"
}

usage() {
  echo -e "$0\\n\\tThis script installs Windows command for WSL2\\n"
  echo "Usage:"
  echo "  install           : install Windows command for WSL2"
}

main() {
  local cmd=$1
  configure_path=$(pwd)/$(dirname $0)/../.windows_commands

  if [[ $cmd == "install" ]]; then
    install
  elif [[ $cmd == "uninstall" ]]; then
    uninstall
  else
    usage
  fi
}

main "$@"
