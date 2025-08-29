#!/bin/bash

# Définir le mot de passe de l'utilisateur kali si variable d'env présente
if [ ! -z "$KALI_PASSWORD" ]; then
    echo "kali:$KALI_PASSWORD" | chpasswd
    # Activer l'authentification par mot de passe
    sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
else
    # Désactiver l'authentification par mot de passe
    sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
    sed -i 's/^PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
fi

# Ajouter une clé publique si variable d'env présente
if [ ! -z "$KALI_PUBKEY" ]; then
    mkdir -p /home/kali/.ssh
    echo "$KALI_PUBKEY" > /home/kali/.ssh/authorized_keys
    chown -R kali:kali /home/kali/.ssh
    chmod 600 /home/kali/.ssh/authorized_keys
fi

# Démarrer le serveur SSH avec ou sans debug
if [ ! -z "$DEBUG" ]; then
    exec /usr/sbin/sshd -D -e
else
    exec /usr/sbin/sshd -D
fi