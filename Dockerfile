FROM kalilinux/kali-rolling

RUN apt-get update && \
    apt-get install -y --no-install-recommends openssh-server sudo && \
    useradd --create-home --shell /bin/bash kali && \
    echo "kali ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/kali && \
    sed -i 's/#AllowTcpForwarding yes/AllowTcpForwarding yes/' /etc/ssh/sshd_config && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 22

CMD ["/init.sh"]
