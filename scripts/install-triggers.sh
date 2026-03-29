#!/usr/bin/env bash
# install-triggers.sh
# Installs wiki-rewrite trigger workflows into each source repository.
# Requires: gh CLI authenticated with write access to source repos.
#
# Usage: ./scripts/install-triggers.sh

set -euo pipefail

declare -A REPO_MAP=(
  ["kijko-ai/panopticon"]="panopticon"
  ["kijko-ai/HyperVisa3.0"]="hypervisa"
  ["kijko-ai/baton-exchange"]="baton-exchange"
  ["david-kijko/Kijko_Docs"]="kijko-frontend"
)

for repo in "${!REPO_MAP[@]}"; do
  name="${REPO_MAP[$repo]}"
  echo "=== Installing trigger for $repo -> wiki-rewrite-$name ==="

  WORKFLOW=$(cat <<YAML
name: Trigger Wiki Rewrite
on:
  push:
    branches: [main]
    paths-ignore:
      - '*.md'
      - '.github/**'
      - 'docs/**'
  release:
    types: [published]

jobs:
  trigger-wiki:
    runs-on: ubuntu-latest
    steps:
      - name: Dispatch wiki rewrite
        run: |
          gh api repos/david-kijko/Kijko-wiki/dispatches \\
            -f event_type=wiki-rewrite-$name \\
            -f "client_payload[commit]=\${{ github.sha }}" \\
            -f "client_payload[ref]=\${{ github.ref }}" \\
            -f "client_payload[actor]=\${{ github.actor }}"
        env:
          GH_TOKEN: \${{ secrets.WIKI_DISPATCH_TOKEN }}
YAML
  )

  # Check if we can access the repo
  if gh repo view "$repo" --json name &>/dev/null; then
    # Create the workflow file via GitHub API
    ENCODED=$(echo "$WORKFLOW" | base64 -w0)

    # Check if file already exists
    EXISTING_SHA=$(gh api "repos/$repo/contents/.github/workflows/trigger-wiki.yml" --jq '.sha' 2>/dev/null || echo "")

    if [ -n "$EXISTING_SHA" ]; then
      echo "  Updating existing trigger workflow..."
      gh api "repos/$repo/contents/.github/workflows/trigger-wiki.yml" \
        -X PUT \
        -f message="chore: update wiki rewrite trigger" \
        -f content="$ENCODED" \
        -f sha="$EXISTING_SHA" \
        --silent && echo "  Updated successfully" || echo "  WARN: Could not update (check permissions)"
    else
      echo "  Creating new trigger workflow..."
      gh api "repos/$repo/contents/.github/workflows/trigger-wiki.yml" \
        -X PUT \
        -f message="chore: add wiki rewrite trigger" \
        -f content="$ENCODED" \
        --silent && echo "  Created successfully" || echo "  WARN: Could not create (check permissions)"
    fi
  else
    echo "  SKIP: Cannot access $repo (private or missing)"
  fi
  echo ""
done

echo "=== Done ==="
echo ""
echo "IMPORTANT: Each source repo needs a WIKI_DISPATCH_TOKEN secret"
echo "that has 'repo' scope access to david-kijko/Kijko-wiki."
echo ""
echo "Create a PAT at: https://github.com/settings/tokens/new"
echo "  - Scopes: repo (full control)"
echo "  - Then add as secret in each source repo:"
echo "    gh secret set WIKI_DISPATCH_TOKEN --repo OWNER/REPO"
