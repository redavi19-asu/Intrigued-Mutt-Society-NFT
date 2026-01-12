#!/bin/bash

# Script to optimize interactive.mp4 for smooth web playback
# This ensures the video has:
# - H.264 codec for universal browser support
# - Faststart flag for quick loading
# - yuv420p pixel format for compatibility
# - Optimized bitrate for smooth streaming

INPUT="Grok-Video-88B7A380-EBD7-4408-A095-0478DC312F08.mp4"
OUTPUT="Grok-Video-88B7A380-EBD7-4408-A095-0478DC312F08.mp4"
BACKUP="Grok-Video-original.mp4"

echo "🎬 Optimizing Grok-Video-88B7A380-EBD7-4408-A095-0478DC312F08.mp4 for smooth playback..."

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "❌ Error: ffmpeg is not installed."
    echo "Install it with: sudo apt-get install ffmpeg"
    exit 1
fi

# Check if input file exists
if [ ! -f "$INPUT" ]; then
    echo "❌ Error: Grok-Video-88B7A380-EBD7-4408-A095-0478DC312F08.mp4 not found!"
    exit 1
fi

# Backup original
echo "📦 Creating backup: $BACKUP"
cp "$INPUT" "$BACKUP"

# Optimize video
echo "⚙️  Processing video for smooth playback..."
ffmpeg -i "$INPUT" \
  -c:v libx264 \
  -preset slow \
  -crf 22 \
  -pix_fmt yuv420p \
  -movflags +faststart \
  -profile:v high \
  -level 4.0 \
  -r 30 \
  -g 60 \
  -bf 2 \
  -c:a aac \
  -b:a 128k \
  -ar 48000 \
  -y \
  "$OUTPUT"

if [ $? -eq 0 ]; then
    echo "✅ Optimization complete!"
    echo "📊 File sizes:"
    ls -lh "$BACKUP" "$OUTPUT"
    
    echo ""
    echo "🔄 Replace original with optimized version? (y/n)"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        mv "$OUTPUT" "$INPUT"
        echo "✅ Replaced $INPUT with optimized version"
        echo "💾 Original saved as $BACKUP"
    else
        echo "ℹ️  Optimized version saved as $OUTPUT"
        echo "ℹ️  Original kept as $INPUT"
    fi
else
    echo "❌ Error during optimization"
    exit 1
fi

echo ""
echo "🎉 Done! Your video should now play smoothly in browsers."
