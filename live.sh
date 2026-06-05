#!/bin/bash

# Tamil Christian Songs 24/7 YouTube Live Stream
# Songs from: https://archive.org/details/09.-aaviai-malaipola

STREAM_KEY="t0dj-9tz0-c117-wxjd-4z17"
PLAYLIST="playlist.txt"
BACKGROUND="background.png"

while true; do
  shuf "$PLAYLIST" | while read -r AUDIO_URL; do
    echo "Now playing: $AUDIO_URL"
    ffmpeg \
      -loop 1 -framerate 1 -i "$BACKGROUND" \
      -i "$AUDIO_URL" \
      -map 0:v -map 1:a \
      -vcodec libx264 \
      -pix_fmt yuv420p \
      -preset ultrafast \
      -tune stillimage \
      -r 1 \
      -g 2 \
      -s 1280x720 \
      -b:v 200k \
      -maxrate 400k \
      -bufsize 800k \
      -c:a aac \
      -b:a 128k \
      -ar 44100 \
      -ac 2 \
      -shortest \
      -f flv \
      "rtmp://a.rtmp.youtube.com/live2/$STREAM_KEY" \
      2>/dev/null || true
    sleep 1
  done
done
