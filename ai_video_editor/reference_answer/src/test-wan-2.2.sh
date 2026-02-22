#!/bin/bash

# Test script for WAN 2.2 Animate Mix API using specific OSS URLs
# This script creates a character animation task using the WAN API directly

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
DASHSCOPE_API_KEY="${DASHSCOPE_API_KEY:-sk-your-api-key-here}"
DASHSCOPE_REGION="${DASHSCOPE_REGION:-singapore}"

# Set correct base URL based on region
if [[ "$DASHSCOPE_REGION" == "beijing" ]]; then
  BASE_URL="https://dashscope.aliyuncs.com"
else
  BASE_URL="https://dashscope-intl.aliyuncs.com"
fi

# Predefined URLs from your upload
IMAGE_URL='http://YOUR_BUCKET.oss-ap-southeast-1.aliyuncs.com/uploads/images/image-1771778927495.png'
VIDEO_URL='http://YOUR_BUCKET.oss-ap-southeast-1.aliyuncs.com/uploads/videos/video-1771778927506.mp4'

echo "🚀 Testing WAN 2.2 Animate Mix API with predefined OSS URLs..."
echo "Using region: $DASHSCOPE_REGION"
echo "Base URL: $BASE_URL"
echo "Image URL: $IMAGE_URL"
echo "Video URL: $VIDEO_URL"

# Verify that we have an API key
if [[ "$DASHSCOPE_API_KEY" == "sk-your-api-key-here" ]]; then
  echo "❌ Error: Please update your .env file with a real API key."
  exit 1
fi

# Call WAN API with the specific URLs
echo -e "\n🔍 Calling WAN 2.2 Animate Mix API..."
echo "Using image URL: $IMAGE_URL"
echo "Using video URL: $VIDEO_URL"

WAN_RESPONSE=$(curl -s -X POST \
  -H "Authorization: Bearer $DASHSCOPE_API_KEY" \
  -H "Content-Type: application/json" \
  -H "X-DashScope-Async: enable" \
  -d '{
    "model": "wan2.2-animate-mix",
    "input": {
      "image_url": "'"$IMAGE_URL"'",
      "video_url": "'"$VIDEO_URL"'"
    },
    "parameters": {
      "service_mode": "wan-std",
      "mode": "wan-std"
    }
  }' \
  "$BASE_URL/api/v1/services/aigc/image2video/video-synthesis")

echo "WAN API Response: $WAN_RESPONSE"

# Extract task ID from response
TASK_ID=$(echo "$WAN_RESPONSE" | grep -o '"task_id":"[^"]*"' | head -n 1 | sed 's/"task_id":"//' | sed 's/"$//' | tr -d '\r\n')

if [[ "$TASK_ID" != "" ]]; then
  echo -e "\n✅ WAN API call successful!"
  echo "Task ID: $TASK_ID"

  # Poll for completion - check every 30 seconds for up to 5 minutes (10 attempts)
  echo -e "\n⏳ Polling task status (every 30s for up to 5 minutes)..."
  ATTEMPT=1
  MAX_ATTEMPTS=10  # 10 attempts * 30 seconds = 5 minutes

  while [ $ATTEMPT -le $MAX_ATTEMPTS ]; do
    STATUS_RESPONSE=$(curl -s -X GET \
      -H "Authorization: Bearer $DASHSCOPE_API_KEY" \
      "$BASE_URL/api/v1/tasks/$TASK_ID")

    TASK_STATUS=$(echo "$STATUS_RESPONSE" | grep -o '"task_status":"[^"]*"' | head -n 1 | sed 's/"task_status":"//' | sed 's/"$//' | tr -d '\r\n')
    echo "Poll $ATTEMPT/10 - Status: $TASK_STATUS"

    if [[ "$TASK_STATUS" == "SUCCEEDED" ]]; then
      RESULT_URL=$(echo "$STATUS_RESPONSE" | grep -o '"video_url":"[^"]*"' | head -n 1 | sed 's/"video_url":"//' | sed 's/"$//' | tr -d '\r\n')
      if [[ "$RESULT_URL" == "" ]]; then
        # Try alternative path for video_url (might be in results object)
        RESULT_URL=$(echo "$STATUS_RESPONSE" | grep -o '"video_url":"[^"]*"' | head -n 1 | sed 's/"video_url":"//' | sed 's/"$//' | tr -d '\r\n')
        if [[ "$RESULT_URL" == "" ]]; then
          RESULT_URL=$(echo "$STATUS_RESPONSE" | grep -o '"video_url":"[^"]*"' | sed -n 's/.*"results"[^}]*"video_url":"\([^"]*\)".*/\1/p' | head -n 1)
        fi
      fi
      echo -e "\n🎉 Task completed successfully!"
      echo "Final video URL: $RESULT_URL"
      break
    elif [[ "$TASK_STATUS" == "FAILED" ]]; then
      ERROR_MSG=$(echo "$STATUS_RESPONSE" | grep -o '"message":"[^"]*"' | head -n 1 | sed 's/"message":"//' | sed 's/"$//' | tr -d '\r\n')
      if [[ "$ERROR_MSG" == "" ]]; then
        ERROR_MSG="Unknown error"
      fi
      echo -e "\n❌ Task failed: $ERROR_MSG"
      break
    fi

    if [ $ATTEMPT -eq $MAX_ATTEMPTS ]; then
      echo -e "\n⏰ Reached maximum polling time. Task may still be processing."
      echo "Last known status: $TASK_STATUS"
      break
    fi

    sleep 30
    ((ATTEMPT++))
  done
else
  echo -e "\n❌ WAN API task creation failed"
  echo "Response was: $WAN_RESPONSE"
  echo "Make sure your API key is valid and the OSS URLs are publicly accessible."
fi

echo -e "\n🏁 WAN 2.2 Animate Mix API test completed!"