#!/bin/sh

echo "===> Generating new SSH key..."
echo ""
echo "Enter your email:"
read email
ssh-keygen -t rsa -b 4096 -C $email

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

echo "Add this key to your GH account (copied to clipboard)"
cat ~/.ssh/id_rsa.pub
pbcopy < ~/.ssh/id_rsa.pub
open "https://github.com/settings/keys"

echo ""
echo "Press enter when done..."
read

echo "===> Cloning quick setup repo..."
mkdir -p ~/Repos
cd ~/Repos
git clone git@github.com:markalfred/osx-quick-setup.git

cd osx-quick-setup
