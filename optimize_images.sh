#!/bin/bash

# Install prerequisite packages
#
# Linux:
# sudo apt-get update
# sudo apt-get install imagemagick
#
# Mac OS:
# brew install imagemagick

# Check if a directory is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

# Navigate to the specified directory
cd "$1" || exit

# Get the height of the 5K resolution (assuming 5K is 5120 pixels wide)
max_height=2880

# Set compression quality (adjust as needed, 85 is just an example)
quality=50

# Resize all JPEG images in the directory
#sips -Z "$max_height" *.jpg

# Create function that received file size as bytes and returns file size as megabytes/kilobytes
function bytesToSize() {
  bytes=$1
  
  kb=$(echo "scale=2; $bytes / 1024" | bc)
  mb=$(echo "scale=2; $kb / 1024" | bc)
  
  if (( $(echo "$mb > 1" | bc -l) )); then
    echo "$mb MB"
  elif (( $(echo "$kb > 1" | bc -l) )); then
    echo "$kb KB"
  else
    echo "$bytes B"
  fi
}

# Resize and compress all JPEG images in the directory
for file in *.jpg; do
  original_size=$(stat -f%z "$file")

  convert "$file" -resize x"$max_height" -quality "$quality" "$file"
  
  new_size=$(stat -f%z "$file")

  echo "Optimize $file: $(bytesToSize $original_size) -> $(bytesToSize $new_size)"
done

# Example usage
# ./optimize_images.sh .
