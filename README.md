# Docker containers with VNC-noVNC session
The repository contains a Docker image with VNC-noVNC.

Docker image is installed with the following components:

* Desktop environment [**Xfce4**](http://www.xfce.org)
* VNC-Server (default VNC port '5910`)
* [**noVNC**](https://github.com/kanaka/noVNC) - HTML5 VNC client (default http port `8000`)
* And records in mp4 the first connection to the server on a file in /root/recording/
* Browsers:
  * Mozilla Firefox

### Current provided OS & UI sessions:
* __Centos7 with `Xfce4` UI session:__

  Run command with mapping to local port `5901`:

      docker run -d -p 80:8000 -p 5901:5901 s4ntos/centos-xfce-vnc-novnc

  Build image from scratch:

      docker build -t centos-xfce-vnc-novnc centos-xfce-vnc-novnc

  => connect via __VNC viewer `localhost:5901`__, default password: `abcABC123`

  => connect via __noVNC HTML5 client__: [http://localhost/]()

#### TODO

* --Push recording to an object store--
* --Stop everything after push--
* Create random password on startup of docker 
* Create a higher level of authentication