FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget curl git python3 python3-pip neofetch && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN wget -qO /bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 && \
    chmod +x /bin/ttyd

RUN mkdir -p /root/workspace

RUN echo "cd /root/workspace" >> /root/.bashrc && \
    echo "neofetch" >> /root/.bashrc

EXPOSE $PORT

CMD ["/bin/bash", "-c", "/bin/ttyd -p ${PORT:-8080} -c ${USERNAME:-admin}:${PASSWORD:-admin} /bin/bash"]