FROM golang:1.21

ENV TZ=Asia/Shanghai \
    PORT=3000

# Install SSH for container access + Python for dummy web
RUN apt-get update && \
    apt-get install -y openssh-server sudo python3 && \
    mkdir -p /var/run/sshd && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install WebTTY
RUN go install github.com/maxmcd/webtty@latest

# Expose ports
EXPOSE 3000 8080

# Start WebTTY and dummy Python web server
CMD bash -c "webtty -cmd bash & python3 -m http.server 8080"
