#!/bin/bash

echo "=== SSH and Git Configuration ==="

read -p "[>] Github username: " USERNAME
read -p "[>] Github email: " EMAIL

KEY_NAME="id_ed25519"

echo "[*] Checking existing SSH access..."
ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"
if [ $? -eq 0 ]; then
	    echo "[*] SSH access already working. Exiting."
	        exit 0
fi

echo "[*] Generating SSH key..."
ssh-keygen -t ed25519 -C "$EMAIL" -f ~/.ssh/$KEY_NAME -N ""

echo "[*] Starting ssh-agent..."
eval "$(ssh-agent -s)"

echo "[*] Adding SSH key to agent..."
ssh-add ~/.ssh/$KEY_NAME

echo "[*] Setting Git global configuration..."
git config --global user.name "$USERNAME"
git config --global user.email "$EMAIL"

echo
echo "[*] SSH key generated. Add the following to your Github account:"
echo "--------------------------------------------------------------------------"
cat ~/.ssh/$KEY_NAME.pub
echo "--------------------------------------------------------------------------"

read -p "[*] Press Enter after you’ve added the key to Github to test the connection..."

echo "[*] Testing SSH connection..."
ssh -T git@github.com

