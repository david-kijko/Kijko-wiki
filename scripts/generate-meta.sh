#!/usr/bin/env bash
# generate-meta.sh
# Regenerates root meta.json and per-folder meta.json files for Fumadocs navigation.
# Run from the Kijko-wiki root.

set -euo pipefail

WIKI_ROOT="${1:-.}"

echo "=== Generating meta.json files ==="

# Build root meta.json
# Discover all wiki folders and single-page MDX files
ROOT_PAGES='["index", "getting-started"'

for dir in panopticon panopticon-2.0 hypervisa-3.0 kijko-frontend baton-exchange; do
  if [ -d "$WIKI_ROOT/$dir" ]; then
    MDX_COUNT=$(find "$WIKI_ROOT/$dir" -name "*.mdx" | wc -l)
    if [ "$MDX_COUNT" -gt 0 ]; then
      # Create human-readable label
      LABEL=$(echo "$dir" | sed 's/-/ /g; s/\b\(.\)/\u\1/g; s/ \([0-9]\)/\1/g')
      ROOT_PAGES="$ROOT_PAGES, \"---${LABEL}---\", \"$dir\""
      echo "  Added folder: $dir ($MDX_COUNT pages)"
    fi
  fi
done

ROOT_PAGES="$ROOT_PAGES]"

cat > "$WIKI_ROOT/_shared/meta.json" <<EOF
{
  "root": true,
  "pages": $ROOT_PAGES
}
EOF

echo "  Root meta.json: $ROOT_PAGES"

# Generate per-folder meta.json where missing
for dir in panopticon panopticon-2.0 hypervisa-3.0 kijko-frontend baton-exchange; do
  META="$WIKI_ROOT/$dir/meta.json"
  if [ -d "$WIKI_ROOT/$dir" ] && [ ! -f "$META" ]; then
    # Auto-generate from MDX files
    PAGES=$(find "$WIKI_ROOT/$dir" -maxdepth 1 -name "*.mdx" -printf '%f\n' | sed 's/\.mdx$//' | sort | while read slug; do
      if [ "$slug" = "index" ]; then
        echo -n "\"index\", "
      fi
    done)

    # Put index first, then rest alphabetically
    node -e "
      const fs = require('fs');
      const path = require('path');
      const dir = '$WIKI_ROOT/$dir';
      const files = fs.readdirSync(dir)
        .filter(f => f.endsWith('.mdx'))
        .map(f => f.replace('.mdx', ''));
      const pages = [];
      if (files.includes('index')) pages.push('index');
      if (files.includes('quickstart')) pages.push('quickstart');
      if (files.includes('concepts')) pages.push('concepts');
      if (files.includes('architecture')) pages.push('architecture');
      files.filter(f => !['index','quickstart','concepts','architecture'].includes(f))
        .sort()
        .forEach(f => pages.push(f));
      fs.writeFileSync('$META', JSON.stringify({ pages }, null, 2));
      console.log('  Generated $META:', pages.length, 'pages');
    " 2>/dev/null || echo "  WARN: Could not generate $META"
  fi
done

echo "=== Done ==="
