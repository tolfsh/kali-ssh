#!/bin/bash

# Définir le mot de passe de l'utilisateur kali si variable d'env présente
if [ ! -z "$KALI_PASSWORD" ]; then
    echo "kali:$KALI_PASSWORD" | chpasswd
fi

# Ajouter une clé publique si variable d'env présente
if [ ! -z "$KALI_PUBKEY" ]; then
    mkdir -p /home/kali/.ssh
    echo "$KALI_PUBKEY" > /home/kali/.ssh/authorized_keys
    chown -R kali:kali /home/kali/.ssh
    chmod 600 /home/kali/.ssh/authorized_keys
fi

# Démarrer le serveur SSH
exec /usr/sbin/sshd -D -e