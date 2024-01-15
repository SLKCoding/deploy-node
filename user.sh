#!/bin/bash

USERNAME=""
SSH_PUBLIC_KEY=""

sudo useradd -m -d /home/$USERNAME -s /bin/bash $USERNAME
sudo mkdir -p /home/$USERNAME/.ssh
echo $SSH_PUBLIC_KEY | sudo dd of=/home/$USERNAME/.ssh/authorized_keys
sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh
sudo chmod 700 /home/$USERNAME/.ssh
sudo chmod 600 /home/$USERNAME/.ssh/authorized_keys
echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/sudoers