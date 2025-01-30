#!/bin/bash

# Directory containing this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Get the project root directory (parent of scripts directory)
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
# Functions directory path
FUNCTIONS_DIR="$PROJECT_ROOT/functions"
# Layers directory path
LAYERS_DIR="$PROJECT_ROOT/layers"

echo "🔍 Looking for function directories in: $FUNCTIONS_DIR"
echo "🔍 Looking for layer directories in: $LAYERS_DIR"

# Check if functions directory exists
if [ ! -d "$FUNCTIONS_DIR" ]; then
    echo "❌ Error: Functions directory not found at $FUNCTIONS_DIR"
    exit 1
fi

# Check if layers directory exists
if [ ! -d "$LAYERS_DIR" ]; then
    echo "❌ Error: Layers directory not found at $LAYERS_DIR"
    exit 1
fi

# Counter for successful and failed builds
successful_builds=0
failed_builds=0

# Function to process a directory
process_directory() {
    local dir=$1
    local dir_name=$(basename "$dir")
    
    echo "📦 Processing directory: $dir_name"
    echo "   Directory: $dir"
    
    # Check if package.json exists
    if [ ! -f "$dir/package.json" ]; then
        echo "   ⚠️  Skipping: No package.json found"
        return
    fi
    
    # Navigate to directory
    cd "$dir" || {
        echo "   ❌ Failed to enter directory"
        ((failed_builds++))
        return
    }
    
    echo "   📥 Installing dependencies..."
    if npm install; then
        echo "   ✅ Dependencies installed successfully"
        
        echo "   🛠️  Running build..."
        if npm run build; then
            echo "   ✅ Build successful"
            ((successful_builds++))
        else
            echo "   ❌ Build failed"
            ((failed_builds++))
        fi
    else
        echo "   ❌ npm install failed"
        ((failed_builds++))
    fi
    
    # Return to original directory
    cd - > /dev/null
    echo "   ✨ Finished processing $dir_name"
    echo "-------------------------------------------"
}

# Process all function directories
for dir in "$FUNCTIONS_DIR"/*; do
    if [ -d "$dir" ]; then
        process_directory "$dir"
    fi
done

# Process all layer directories
for dir in "$LAYERS_DIR"/*; do
    if [ -d "$dir" ]; then
        process_directory "$dir"
    fi
done

# Print summary
echo "🎉 Build process complete!"
echo "✅ Successful builds: $successful_builds"
echo "❌ Failed builds: $failed_builds"

# Exit with error if any builds failed
if [ "$failed_builds" -gt 0 ]; then
    exit 1
fi