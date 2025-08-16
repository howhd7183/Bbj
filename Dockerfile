FROM golang:1.21

ENV TZ=Asia/Shanghai

# Install SSH for container access
RUN apt-get update && apt-get install -y openssh-server sudo && \
    mkdir -p /var/run/sshd && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install WebTTY
RUN go install github.com/maxmcd/webtty@latest

# Expose webtty port (any port, used by WebRTC signaling)
EXPOSE 3000

CMD ["webtty", "-cmd", "bash"]
