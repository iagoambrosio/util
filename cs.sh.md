# THE GREATE CHEATSHEET de comandos linux

##Comando para adicionar usuário , grupo, escolher shell, definir e criar home e definir ##senha

sudo useradd -G sudo -s /bin/bash -d /home/helpdesk -m helpdesk -p '$1$zcSV3347$eY26c39BGVHopRfMKO6Ex0'

##para delimitar um hash de senha que o linux aceite
openssl passwd -1 "<aqui vai a senha>"

##Converte vhdx em qcow2 

qemu-img convert -O qcow2 Bench-Dev.vhdx /var/lib/vz/images/112/vm-112-disk-1.qcow2

##