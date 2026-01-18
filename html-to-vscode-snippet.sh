#!/usr/bin/env bash
# html-to-vscode-snippet-pack.sh
# Convert one or more HTML files (or stdin) into a VS Code snippet pack.
# Automatically names snippets after filenames (without extension).
#
# Usage:
#   ./html-to-vscode-snippet-pack.sh snippets.json file1.html file2.html ...
#   ./html-to-vscode-snippet-pack.sh snippets.json path/to/html/files/
#   cat snippet.html | ./html-to-vscode-snippet-pack.sh snippets.json
#
# Each snippet name & prefix = filename (e.g., "card.html" -> "card")

# check args
if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <output.json> [input files or directory or stdin]"
  exit 1
fi

OUTPUT_FILE="$1"
shift

# if output doesn't exist, initialize empty JSON
if [ ! -f "$OUTPUT_FILE" ]; then
  echo "{}" > "$OUTPUT_FILE"
fi

# function to escape HTML for JSON snippet
escape_html() {
  sed 's/\\/\\\\/g; s/"/\\"/g'
}

# function to convert one HTML file into snippet JSON block
convert_html_to_snippet() {
  local SNIPPET_NAME="$1"
  local HTML_CONTENT="$2"

  local ESCAPED=$(echo "$HTML_CONTENT" | escape_html)
  local LINES=$(echo "$ESCAPED" | awk '{print "      \"" $0 "\","}' | sed '$ s/,$//')

  cat <<EOF
  "$SNIPPET_NAME": {
    "prefix": "$SNIPPET_NAME",
    "body": [
$LINES
    ],
    "description": "Snippet generated from $SNIPPET_NAME.html"
  }
EOF
}

# function to merge new snippet into existing JSON
add_snippet_to_file() {
  local SNIPPET_JSON="$1"
  local TMP_FILE=$(mktemp)

  # remove trailing } safely
  sed '$d' "$OUTPUT_FILE" > "$TMP_FILE"
  # if file has only { } (empty), avoid comma
  if grep -q '": {' "$TMP_FILE"; then
    echo ", $SNIPPET_JSON }" >> "$TMP_FILE"
  else
    echo "$SNIPPET_JSON }" >> "$TMP_FILE"
  fi
  mv "$TMP_FILE" "$OUTPUT_FILE"
}

# detect input mode
if [ "$#" -eq 0 ]; then
  # read from stdin
  HTML_CONTENT=$(cat)
  SNIPPET_NAME="snippet_$(date +%s)"
  SNIPPET_JSON=$(convert_html_to_snippet "$SNIPPET_NAME" "$HTML_CONTENT")
  add_snippet_to_file "$SNIPPET_JSON"
  echo "✅ Added snippet \"$SNIPPET_NAME\" (from stdin)"
else
  for ITEM in "$@"; do
    if [ -d "$ITEM" ]; then
      # directory: find all .html files
      FILES=$(find "$ITEM" -type f -name "*.html")
      for FILE in $FILES; do
        BASENAME=$(basename "$FILE" .html)
        HTML_CONTENT=$(cat "$FILE")
        SNIPPET_JSON=$(convert_html_to_snippet "$BASENAME" "$HTML_CONTENT")
        add_snippet_to_file "$SNIPPET_JSON"
        echo "✅ Added snippet \"$BASENAME\" from $FILE"
      done
    elif [ -f "$ITEM" ]; then
      BASENAME=$(basename "$ITEM" .html)
      HTML_CONTENT=$(cat "$ITEM")
      SNIPPET_JSON=$(convert_html_to_snippet "$BASENAME" "$HTML_CONTENT")
      add_snippet_to_file "$SNIPPET_JSON"
      echo "✅ Added snippet \"$BASENAME\" from $ITEM"
    else
      echo "⚠️ Skipping: $ITEM (not found)"
    fi
  done
fi
