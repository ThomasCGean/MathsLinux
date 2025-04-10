<h1>Watch a demonstration of this pipeline here!</h1>
<h1>https://www.youtube.com/watch?v=M-Zdl4d26Iw&t</h1>

This is a fully functional CI/CD pipeline created using Jenkins, Docker, SonarQube, Kubernetes (via kind), and built for analyzing apps written in Java Maven. 


This should work on Docker Engine on any platform that natively supports Docker Desktop (Windows, MacOS, Linux), as well as Docker Engine on Linux. Due to the DOcker socket access given to Jenkins, this pipeline is best run in a virtual environment; compromise of the jenkins container (or the host system running the jenkins container) can result in container escape and privilege escalation to root on the host. 


Usage on docker engine requires adding the daemon.json file (from the useful_scripts folder) to the appropriate directory, /etc/docker/daemon.json . Usage on Docker Desktop simply requires jenkins to have access to the docker socket inside of its container; this can be done in a few ways, including using chmod inside the container to change the permissions on the socket, running jenkins as root, or adding jenkins to the root group.


On Docker Desktop, the Docker socket permission inside the container do not resolve correctly (still not 100% sure why, even after extensive debuging attempts). The socket defaults to being owned by root:root GID 1, regardless of the Docker GID on the host. This issue does not occur when running this pipeline on Docker Engine directlty, without Docker Desktop active. 

![Logo](https://github.com/ThomasCGean/git-practice/blob/master/JenkinsThumbnail.jpg)
