FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Mirror change aur packages install karne ka sahi tarika
RUN sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y wget curl git python3 python3-pip neofetch && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN wget -qO /bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 && \
    chmod +x /bin/ttyd

RUN mkdir -p /root/workspace

RUN echo "cd /root/workspace" >> /root/.bashrc && \
    echo "neofetch" >> /root/.bashrc

ENV PORT=8080
EXPOSE $PORT

CMD ["/bin/sh", "-c", "/bin/ttyd -p ${PORT} -c ${USERNAME:-admin}:${PASSWORD:-admin} /bin/bash"]
