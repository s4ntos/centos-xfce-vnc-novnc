FROM centos:latest
MAINTAINER s4ntos "@s4ntos"

ENV USER xfce4
ENV USER_HOME /home/xfce4
ENV DISPLAY :1
ENV VNC_COL_DEPTH 24
ENV VNC_RESOLUTION 1280x720
ENV VNC_PW abcABC123
ENV VNC_PORT 5901
ENV NOVNC_PORT 8000

RUN yum -y update
RUN yum -y install epel-release 
RUN yum -y install xfce4-session tigervnc-server novnc firefox xterm Thunar xfdesktop
# Temporary packages for vnc2flv 
RUN yum -y install gcc python-devel

# Enable vnc2flv
# VNC2FLV not required because we are able to do this with ffmpeg
# RUN easy_install vnc2flv
RUN mkdir /root/recording/
RUN echo "${VNC_PW}" > /root/recording/passwd  

# Download static versions of ffmpeg
RUN curl -o ffmpeg.tar.xz  https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-64bit-static.tar.xz 
RUN tar xf ffmpeg.tar.xz -C /root/recording/ "*/ffmpeg"

# User to be used and its environment
RUN useradd $USER -d $USER_HOME
ADD user/.vnc $USER_HOME/.vnc
ADD user/.config $USER_HOME/.config
ADD user/Desktop $USER_HOME/Desktop
RUN chmod +x ${USER_HOME}/.vnc/xstartup ${USER_HOME}/Desktop/*.desktop;
RUN echo "${VNC_PW}" | /usr/bin/vncpasswd -f > ${USER_HOME}/.vnc/passwd 2>/dev/null
RUN chown $USER:$USER -R $USER_HOME

# Systemd #
RUN mkdir -p /etc/systemd/system/multi-user.target.wants/
ADD vnc/vncserver /etc/systemd/system/vncserver@:1.service
RUN ln -s /etc/systemd/system/vncserver@:1.service /etc/systemd/system/multi-user.target.wants/vncserver@:1.service
ADD novnc/novnc.service /etc/systemd/system/novnc.service
RUN ln -s /etc/systemd/system/novnc.service /etc/systemd/system/multi-user.target.wants/novnc.service
##########
ADD iptables /etc/sysconfig/iptables
ADD scripts/ /root/scripts
RUN chmod +x /root/scripts/vnc_novnc_startup.sh
# Is this really required? 
RUN dbus-uuidgen > /etc/machine-id

# Clean packages required to build vnc2flv 
RUN yum -y remove mpfr libgomp kernel-headers python-devel

EXPOSE 5901
EXPOSE 8000

CMD ["/root/scripts/vnc_novnc_startup.sh"]