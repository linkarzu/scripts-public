#!/usr/bin/env bash

# Filename: ~/github/scripts-public/macos/mac/350-image-to-all.sh
# ~/github/scripts-public/macos/mac/350-image-to-all.sh

# This script converts all image files in a specified directory to multiple
# formats (avif, webp, jpg, png).
# If no directory is provided as an argument, it converts images in the
# directory where the script is ran.
# Converted images are saved with their original names appended with the target
# format (e.g., "image-avif.avif").
# Subdirectories within the specified directory are ignored.

# Check if a directory argument is provided; if not, use the current directory
if [ -z "$1" ]; then
  IMAGE_DIR="."
else
  IMAGE_DIR="$1"
fi

# Check if the specified path is a valid directory
if [ ! -d "$IMAGE_DIR" ]; then
  echo "Error: $IMAGE_DIR is not a valid directory."
  exit 1
fi

# Supported formats
FORMATS=("avif" "webp" "jpg" "png")
QUALITY=75 # Default quality for conversions

# Loop through all files in the directory (ignore subdirectories)
for image in "$IMAGE_DIR"/*; do
  # Skip if not a file
  [ -f "$image" ] || continue

  # Get the filename without the extension
  filename=$(basename "$image")
  base_name="${filename%.*}"

  # Convert the image to each format
  for format in "${FORMATS[@]}"; do
    # Construct output filename
    output_file="${IMAGE_DIR}/${base_name}-${format}.${format}"

    # Perform the conversion using ImageMagick's convert command
    magick "$image" -quality $QUALITY "$output_file"

    echo "Converted $image to $output_file"
  done
done
