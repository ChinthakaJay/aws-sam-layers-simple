#!/bin/bash

# Directory containing this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Get the project root directory (parent of scripts directory)
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "🚀 Running SAM build and deploy from: $PROJECT_ROOT"

# Navigate to the project root directory
cd "$PROJECT_ROOT" || {
    echo "❌ Failed to navigate to project root directory"
    exit 1
}

# Run sam build
echo "🛠️  Running SAM build..."
if sam build; then
    echo "✅ SAM build completed successfully"
else
    echo "❌ SAM build failed"
    exit 1
fi

# Run sam deploy
echo "🚀 Running SAM deploy..."
if sam deploy; then
    echo "✅ SAM deploy completed successfully"
else
    echo "❌ SAM deploy failed"
    exit 1
fi

echo "🎉 SAM build and deploy process complete!"