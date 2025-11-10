#!/bin/bash
# Script to update manifest.json with new release information
# Usage: ./update-manifest.sh <version> <checksum>
# Example: ./update-manifest.sh 2.0.0.0 c174e6ea8816edb4b89fa97c33a700f3

set -e

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <version> <checksum>"
    echo "Example: $0 2.0.0.0 c174e6ea8816edb4b89fa97c33a700f3"
    exit 1
fi

VERSION=$1
CHECKSUM=$2
TIMESTAMP=$(date -u +"%Y-%m-%d %H:%M:%S")

echo "Updating manifest.json with:"
echo "  Version: $VERSION"
echo "  Checksum: $CHECKSUM"
echo "  Timestamp: $TIMESTAMP"

# Create new version entry
NEW_ENTRY=$(cat <<EOF
            {
                "version": "$VERSION",
                "changelog": "Update changelog here",
                "targetAbi": "10.8.0.0",
                "sourceUrl": "https://github.com/sbcrumb/chronarr-jellyfin-plugin/releases/download/v$VERSION/chronarr-jellyfin-plugin_$VERSION.zip",
                "checksum": "$CHECKSUM",
                "timestamp": "$TIMESTAMP"
            }
EOF
)

echo ""
echo "New manifest entry:"
echo "$NEW_ENTRY"
echo ""
echo "Please manually update manifest.json with this entry."
echo "Update the changelog field with actual release notes."
