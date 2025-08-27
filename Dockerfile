FROM kalilinux/kali-rolling

RUN apt-get update && \
    apt-get install -y --no-install-recommends openssh-server && \
    useradd --create-home --shell /bin/bash kali && \
    sed -i 's/#AllowTcpForwarding yes/AllowTcpForwarding yes/' /etc/ssh/sshd_config && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 22

CMD ["/init.sh"]
