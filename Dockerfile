FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Upgrade ko hatakar direct install karein aur DNS retry handle karein
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget curl git python3 python3-pip neofetch && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN wget -qO /bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 && \
    chmod +x /bin/ttyd

RUN mkdir -p /root/workspace

RUN echo "cd /root/workspace" >> /root/.bashrc && \
    echo "neofetch" >> /root/.bashrc

# Default Port set karein agar environment variable na mile
ENV PORT=8080
EXPOSE $PORT

CMD ["/bin/sh", "-c", "/bin/ttyd -p ${PORT} -c ${USERNAME:-admin}:${PASSWORD:-admin} /bin/bash"]
