#!/bin/bash

USERNAME="deploy"
SSH_PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCbb0hUfOV1wXbJ/AEL6umR+QMo/2gqN5WH7E5TFfIy7TEclxf0pE3FRd9v/n2H5IOzi1YSDnBsEgL4GvnQ9fL2Nq4pnK1VJJF4ocLmjNT7tSJNBKIoKr8UtLmMOXVnaSLBp7FKJbON6rUIDps1V+adA4xUPwkOY/WpdUGcxmZxXAJPVydqNUJ+XMbI2e/Ue1i9quTkCHAPP647zmcF5mKhExgQ6G76ATbEJBaVJ+Y4slR57iJJP/G5Jt1pk/0PLAmplazOPgrMWzMBa6C8jas9vB2kTpNkhvDlFzHxFZizh0CD5LMuz1QKbLcgaxLXwGo/U8pO84s4oB4qSLDWqEXTvbRP1AsXraY7C3iqHtUQ4+POoBJkywJBQ8QF/qNnos9jODQ2Tvj85P2kiD20E9ts+EWYq9OHy+PEiGJOdKq79QSIhXii4d4a0EXXwdDCAb74kRKytipu6hRHzKwGj9KD0KHL4xAyqylldkCWPGCltDPyCVHoOylY9Cz2EhhbyLM= adria@TREZUB-PC"

# Updates
sudo apt-get update && sudo apt-get dist-upgrade -y

# Timezone
sudo ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
sudo dpkg-reconfigure -fnoninteractive tzdata

# Docker repositories
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install docker and nginx
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin nginx

# Create user
sudo useradd -m -d /home/$USERNAME -s /bin/bash $USERNAME
sudo mkdir -p /home/$USERNAME/.ssh
echo $SSH_PUBLIC_KEY | sudo dd of=/home/$USERNAME/.ssh/authorized_keys
sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh
sudo chmod 700 /home/$USERNAME/.ssh
sudo chmod 600 /home/$USERNAME/.ssh/authorized_keys
sudo usermod -aG docker $USERNAME