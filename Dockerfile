FROM kalilinux/kali-rolling

# Installer OpenSSH Server
RUN apt-get update && \
    apt-get install -y openssh-server && \
    mkdir /var/run/sshd

# Créer l'utilisateur kali
RUN useradd -m -s /bin/bash kali

# Ajouter le script d'initialisation
COPY init.sh /init.sh
RUN chmod +x /init.sh

# Activer le port forwarding SSH
RUN sed -i 's/#AllowTcpForwarding yes/AllowTcpForwarding yes/' /etc/ssh/sshd_config

# Exposer le port SSH
EXPOSE 22

# Lancer le script d'init puis sshd
CMD ["/init.sh"]
