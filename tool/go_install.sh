#!/usr/bin/env bash

# Install go latest version

GO_ORG_DOWNLOAD_DOMAIN="https://golang.org"
go_latest_version_path=$(wget -qO- ${GO_ORG_DOWNLOAD_DOMAIN}/dl/ | grep -oP '/dl\/go([0-9\.]+)\.linux-amd64\.tar\.gz' | head -n 1)

echo "Get ${go_latest_version_path} ..."
echo ${GO_ORG_DOWNLOAD_DOMAIN}${go_latest_version_path}
wget ${GO_ORG_DOWNLOAD_DOMAIN}${go_latest_version_path}

go_file_name=$(echo ${go_latest_version_path} | sed -e 's/\/dl\///g')
sudo tar -C /usr/local -xzf ${go_file_name}
export PATH="${PATH}":/usr/local/go/bin
rm ${go_file_name}

go version
