#!/usr/bin/env bash
# sync-to-docs-site.sh
# Syncs wiki content from Kijko-wiki repo to the Kijko_Docs wiki-content directory.
# Run this from the Kijko_Docs root, or set DOCS_ROOT env var.
#
# Usage:
#   DOCS_ROOT=/home/david/Projects/Kijko_Docs ./scripts/sync-to-docs-site.sh
#   # or from Kijko_Docs root:
#   /home/david/Kijko-wiki/scripts/sync-to-docs-site.sh

set -euo pipefail

WIKI_REPO="${WIKI_ROOT:-/home/david/Kijko-wiki}"
DOCS_ROOT="${DOCS_ROOT:-/home/david/Projects/Kijko_Docs}"
WIKI_CONTENT="$DOCS_ROOT/wiki-content/docs"

echo "=== Kijko Wiki -> Docs Site Sync ==="
echo "Wiki source: $WIKI_REPO"
echo "Docs target: $WIKI_CONTENT"

# Pull latest wiki content
cd "$WIKI_REPO"
git pull --ff-only origin main 2>/dev/null || echo "Already up to date"

# Map wiki folders to docs structure
declare -A FOLDER_MAP=(
  ["panopticon"]="panopticon"
  ["panopticon-2.0"]="."
  ["hypervisa-3.0"]="."
  ["kijko-frontend"]="."
  ["baton-exchange"]="."
)

# Sync each repo's wiki
for wiki_dir in panopticon panopticon-2.0 hypervisa-3.0 kijko-frontend baton-exchange; do
  src="$WIKI_REPO/$wiki_dir"
  if [ ! -d "$src" ]; then
    echo "SKIP: $wiki_dir (no directory)"
    continue
  fi

  target_subdir="${FOLDER_MAP[$wiki_dir]}"

  if [ "$target_subdir" = "." ]; then
    # Single-page repos: copy MDX files to docs root
    for f in "$src"/*.mdx; do
      [ -f "$f" ] && cp "$f" "$WIKI_CONTENT/"
      echo "  Copied $(basename "$f") -> $WIKI_CONTENT/"
    done
  else
    # Multi-page repos: sync entire folder
    mkdir -p "$WIKI_CONTENT/$target_subdir"
    rsync -av --delete --include="*.mdx" --include="*.json" --exclude="*-legacy.md" --exclude="*.md" "$src/" "$WIKI_CONTENT/$target_subdir/"
    echo "  Synced $wiki_dir/ -> $WIKI_CONTENT/$target_subdir/"
  fi
done

# Sync shared assets
if [ -d "$WIKI_REPO/_shared" ]; then
  cp "$WIKI_REPO/_shared/index.mdx" "$WIKI_CONTENT/index.mdx" 2>/dev/null || true
  cp "$WIKI_REPO/_shared/getting-started.mdx" "$WIKI_CONTENT/getting-started.mdx" 2>/dev/null || true
  cp "$WIKI_REPO/_shared/meta.json" "$WIKI_CONTENT/meta.json" 2>/dev/null || true
  cp "$WIKI_REPO/_shared/style-system.json" "$DOCS_ROOT/wiki-content/style-system.json" 2>/dev/null || true
  echo "  Synced _shared/ assets"
fi

# Update the main meta.json to include any new pages
echo "=== Sync complete ==="
echo "Run 'npm run build' in $DOCS_ROOT to rebuild the docs site."
