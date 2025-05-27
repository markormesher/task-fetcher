#!/usr/bin/env bash
set -euo pipefail

apt update
apt install -y --no-install-recommends curl ca-certificates jq

latest_tag=$(curl --fail https://api.github.com/repos/go-task/task/releases/latest | jq -rc '.tag_name')
echo "Latest version: ${latest_tag}"
sed -i -r "s/TASK_VERSION=\"v[0-9.]+\"/TASK_VERSION=\"${latest_tag}\"/" /tedium/repo/Containerfile /tedium/repo/.circleci/config.yml
