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
    ffmpeg -re -stream_loop -1 -i "$BACKGROUND" \
           -i "$AUDIO_URL" \
           -map 0:v -map 1:a \
           -vcodec libx264 \
           -pix_fmt yuvj420p \
           -maxrate 2000k \
           -preset veryfast \
           -r 30 \
           -g 60 \
           -c:a aac \
           -b:a 128k \
           -ar 44100 \
           -strict experimental \
           -video_track_timescale 1000 \
           -s 1280x720 \
           -b:v 1500k \
           -f flv \
           -ac 2 \
           "rtmp://a.rtmp.youtube.com/live2/$STREAM_KEY" \
           2>/dev/null || true
  done
done
