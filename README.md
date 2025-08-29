# kali-ssh

This repo aims to create a [Kali Linux](https://www.kali.org/docs/containers/official-kalilinux-docker-images/) docker image with a SSH server embedded. 

## Run
Generate a SSH key and run the container :
```bash
ssh-keygen -N "" -q -f ./kali
docker run --name kali -it -p 2222:22 -e KALI_PUBKEY=$(cat ./kali.pub) tolfsh/kali-ssh
```
Or use a password (or both):
```bash
docker run --name kali -it -e KALI_PASSWORD='sup3rS3cr3t' tolfsh/kali-ssh
```

## Build
You can build and run the image yourself:
```bash
git clone https://github.com/tolfsh/kali-ssh
cd kali-ssh
docker build -t kali-ssh .
docker run --name kali -it -p 2222:22 -e KALI_PASSWORD='sup3rS3cr3t' kali-ssh
```