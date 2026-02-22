#!/bin/bash

# Test script for OSS upload via server endpoint
# This script uploads local files to OSS through the server

# Load environment variables
if [ -f .env ]; then
  # Process the .env file line by line
  while IFS= read -r line; do
    # Skip empty lines and comments
    if [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]]; then
      continue
    fi
    
    # Split on the first '=' to handle values with '=' in them
    if [[ "$line" =~ ^([^=]+)=(.*)$ ]]; then
      key="${BASH_REMATCH[1]}"
      value="${BASH_REMATCH[2]}"
      
      # Remove leading/trailing whitespace
      key=$(echo "$key" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
      value=$(echo "$value" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
      
      # Remove any trailing comments from the value (everything after #)
      if [[ "$value" =~ ^([^#]*)# ]]; then
        value="${BASH_REMATCH[1]}"
        # Trim trailing whitespace after removing comment
        value=$(echo "$value" | sed 's/[[:space:]]*$//')
      fi
      
      export "$key=$value"
    fi
  done < .env
fi

# Variables
SERVER_URL="http://localhost:3000"

# Local sample files
IMAGE_PATH="./samples/cutie_wizard.png"  # Update with your image path
VIDEO_PATH="./samples/dancing.mp4"      # Update with your video path

echo "🚀 Testing OSS Upload via Server..."
echo "Server URL: $SERVER_URL"

# Check if files exist
if [[ ! -f "$IMAGE_PATH" ]]; then
  echo "❌ Image file does not exist: $IMAGE_PATH"
  exit 1
fi

if [[ ! -f "$VIDEO_PATH" ]]; then
  echo "❌ Video file does not exist: $VIDEO_PATH"
  exit 1
fi

echo "✅ Files exist, proceeding with OSS upload test..."

# Upload files to server (which will upload to OSS)
echo -e "\n📁 Uploading local files to OSS via server..."
echo "Uploading image: $IMAGE_PATH"
echo "Uploading video: $VIDEO_PATH"

UPLOAD_RESPONSE=$(curl -s -X POST \
  -F "image=@$IMAGE_PATH" \
  -F "video=@$VIDEO_PATH" \
  "$SERVER_URL/upload")

echo "Upload Response: $UPLOAD_RESPONSE"

# Extract OSS URLs from response
IMAGE_URL=$(echo "$UPLOAD_RESPONSE" | grep -o '"imageUrl":"[^"]*"' | head -n 1 | sed 's/"imageUrl":"//' | sed 's/"$//' | tr -d '\r\n')
VIDEO_URL=$(echo "$UPLOAD_RESPONSE" | grep -o '"videoUrl":"[^"]*"' | head -n 1 | sed 's/"videoUrl":"//' | sed 's/"$//' | tr -d '\r\n')

if [[ "$IMAGE_URL" != "" && "$VIDEO_URL" != "" ]]; then
  echo -e "\n✅ Files uploaded to OSS successfully!"
  echo "Image URL: $IMAGE_URL"
  echo "Video URL: $VIDEO_URL"
  echo ""
  echo "📋 You can now use these URLs with the WAN API:"
  echo "   Image URL: $IMAGE_URL"
  echo "   Video URL: $VIDEO_URL"
else
  echo -e "\n❌ Upload to OSS failed"
  echo "Response was: $UPLOAD_RESPONSE"
  echo "Make sure your server is running and configured with valid OSS credentials."
fi

echo -e "\n🏁 OSS Upload test completed!"