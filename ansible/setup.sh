#!/bin/bash
#Rodar esse script para preparar o ambiente
#
sudo apt install ansible sshpass
ssh-keygen -f id_rsa -P ""
cp id_rsa $HOME/.ssh/ 
cp ansible.cfg /etc/ansible/

#Após a execução do playbook 2, trocar o usuário para "ansible" para manter os playbooks funcionais
