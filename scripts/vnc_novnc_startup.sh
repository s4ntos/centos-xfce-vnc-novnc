#!/bin/bash
/usr/bin/vncserver -kill ${DISPLAY} > /dev/null 2>&1 || :
/sbin/runuser -l xfce4 -c "/usr/bin/vncserver ${DISPLAY} -depth ${VNC_COL_DEPTH} -geometry ${VNC_RESOLUTION}"
/sbin/runuser -l xfce4 -c "/usr/bin/python /usr/bin/websockify --web /usr/bin/../share/novnc/ ${NOVNC_PORT} localhost:${VNC_PORT}" &
# for each xauth add 
cp /home/xfce4/.Xauthority /root
/root/recording/ffmpeg*/ffmpeg -f x11grab -video_size ${VNC_RESOLUTION} -framerate 2 -i :1  -crf 40 -c:v libx264 -vf "drawtext='fontcolor=red:text=%{localtime}'" /root/recording/video.mp4 &
tail -fn0 /home/xfce4/.vnc/*.log | awk '/closed/ { print | "/root/scripts/vnc_novnc_stop.sh" }'
