FROM ubuntu:16.04

RUN sed -i "s/http:\/\/archive.ubuntu.com/http:\/\/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list && \
    apt-get update && apt-get -y dist-upgrade && \
    apt-get install -y lib32z1

RUN useradd -m ctf

WORKDIR /home/ctf

COPY ./start.sh /start.sh

RUN chmod +x /start.sh

COPY ./bin/ /home/ctf/

RUN chown -R root:ctf /home/ctf && \
    chmod -R 750 /home/ctf && \
    chmod 440 /home/ctf/flag && \
    chmod -R 777 /home/ctf/var/log/boa

RUN cp -rf /home/ctf/etc/boa /etc/boa && \
    cp -rf /home/ctf/etc/mime.types /etc/mime.types && \
    ln -s /home/ctf/flag /flag && \
    cp -rf /home/ctf/var/log/boa /var/log/boa


CMD ["/start.sh"]

EXPOSE 80
