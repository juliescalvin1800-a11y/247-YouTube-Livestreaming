#!/bin/bash

# Tamil Christian Songs 24/7 YouTube Live Stream
# Songs from: https://archive.org/details/09.-aaviai-malaipola

STREAM_KEY="YOUR_YOUTUBE_STREAM_KEY_HERE"
PLAYLIST="playlist.txt"
BACKGROUND="video.mp4"

while true; do
  # Shuffle playlist each loop
  shuf "$PLAYLIST" | while read -r AUDIO_URL; do
    echo "Now playing: $AUDIO_URL"
    ffmpeg -re \
           -stream_loop -1 -i "$BACKGROUND" \
           -i "$AUDIO_URL" \
           -map 0:v -map 1:a \
           -vcodec libx264 \
           -pix_fmt yuv420p \
           -preset ultrafast \
           -tune zerolatency \
           -r 24 \
           -g 48 \
           -s 854x480 \
           -b:v 800k \
           -maxrate 1000k \
           -bufsize 2000k \
           -c:a aac \
           -b:a 128k \
           -ar 44100 \
           -ac 2 \
           -strict experimental \
           -video_track_timescale 1000 \
           -f flv \
           "rtmp://a.rtmp.youtube.com/live2/$STREAM_KEY" \
           2>/dev/null || true
    sleep 1
  done
done
