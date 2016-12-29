#!/bin/sh
echo 'Hello World!'
ffmpeg-git-20161122-64bit-static/ffmpeg -i /root/recording/video.flv -crf 40 -c:v libx264 -vf "drawtext='fontfile=/usr/share/fonts/dejavu/DejaVuSansMono-Bold.ttf:fontcolor=red:text=%{localtime\:%a %b %d %Y}'" /root/recording/video.mp4
# ffmpeg-git-20161122-64bit-static/ffmpeg -i video2.flv -crf 40 -c:v libx264 -vf "drawtext='fontfile=/usr/share/fonts/dejavu/DejaVuSansMono-Bold.ttf:fontcolor=red:text=%{localtime\:%a %b %d %Y}'" video5.mp4
#ffmpeg -framerate 25 -video_size 1024x768 -f x11grab -i :0.0+100,200 -f alsa -ac 2 -i pulse -vcodec libx264 -crf 0 -preset ultrafast -acodec pcm_s16le output.mkv
#ffmpeg-git-20161122-64bit-static/ffmpeg -framerate 25 -video_size 1024x768 -f x11grab -vcodec libx264 -crf 0 -preset ultrafast output.mkv
#./ffmpeg-git-20161122-64bit-static/ffmpeg -f x11grab -framerate 2 -video_size cif -i :1  -crf 40 -c:v libx264 -vf "drawtext='fontfile=/usr/share/fonts/dejavu/DejaVuSansMono-Bold.ttf:fontcolor=red:text=%{localtime\:%a %b %d %Y}'" video6.mp4
#ffmpeg -f x11grab -framerate 2 -video_size cif -i :1  -crf 40 -c:v libx264 -vf "drawtext='fontfile=/usr/share/fonts/dejavu/DejaVuSansMono-Bold.ttf:fontcolor=red:text=%{localtime\:%a %b %d %Y}'" video6.mp4