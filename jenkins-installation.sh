#!/bin/bash

# Jenkins LTS Installation Script for Ubuntu/Debian
# Exits immediately if a command fails
set -e

echo "============================================="
echo " Starting Jenkins LTS Installation (Ubuntu)  "
echo "============================================="

echo "-> Step 1: Installing Java (OpenJDK 21 )..."
sudo apt update
sudo apt install fontconfig openjdk-21-jre -y

echo "-> Step 2: Adding Jenkins GPG key and repository..."
sudo mkdir -p /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "-> Step 3: Installing Jenkins..."
sudo apt update
sudo apt install jenkins -y

echo "-> Step 4: Starting and enabling Jenkins service..."
sudo systemctl is-active jenkins

echo "============================================="
echo " Installation Complete!                      "
echo "============================================="

echo "Waiting 5 seconds for Jenkins to generate the initial password..."
sleep 5

echo ""
echo "Your Initial Administrator Password is:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword || echo "(File not ready yet. Please run: sudo cat /var/lib/jenkins/secrets/initialAdminPassword)"
echo ""