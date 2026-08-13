#!/usr/bin/env bash
set -euo pipefail

echo "SIMULATED_ATTACK_CONTROL_REACHED"
echo "The pull request changed mvnw, and CI executed it."
echo "The command looked like a normal build: $*"

mkdir -p .rca-demo
evidence_file=".rca-demo/evidence.txt"

{
  echo "simulated_stage=initial-pr-compromise"
  echo "attacker_control=true"
  echo "base_repository=${BASE_REPOSITORY:-unknown}"
  echo "head_repository=${HEAD_REPOSITORY:-unknown}"
  echo "head_sha=${HEAD_SHA:-unknown}"
  echo "pr_number=${PR_NUMBER:-unknown}"
} > "$evidence_file"

if [[ -n "${PAT_TO_FORK:-}" ]]; then
  echo "PAT_TO_FORK_VISIBLE=true"
  echo "PAT_TO_FORK_LENGTH=${#PAT_TO_FORK}"
  {
    echo "canary_secret_present=true"
    echo "canary_secret_length=${#PAT_TO_FORK}"
    printf "%s" "$PAT_TO_FORK" | sha256sum | awk '{ print "canary_secret_sha256_prefix=" substr($1, 1, 16) }'
  } >> "$evidence_file"
else
  echo "PAT_TO_FORK_VISIBLE=false"
  echo "canary_secret_present=false" >> "$evidence_file"
fi

cat >> "$evidence_file" <<'EOT'
