#!/bin/bash

# Function to check if SSHFS is installed
check_sshfs() {
    if ! command -v sshfs &> /dev/null; then
        echo "SSHFS is not installed. Installing..."
        sudo apt-get update
        sudo apt-get install -y sshfs
        echo "SSHFS installed successfully."
    else
        echo "SSHFS is already installed."
    fi
}

# Function to check if mount point /mnt/aws exists, create it if not
check_mount_point() {
    if [ ! -d "/mnt/aws" ]; then
        echo "Creating mount point /mnt/aws..."
        sudo mkdir -p /mnt/aws
        echo "Mount point /mnt/aws created."
    else
        echo "Mount point /mnt/aws already exists."
    fi
}

# Function to check if AWS home directory is mounted, mount it if not
mount_aws_home() {
    if ! grep -qs '/mnt/aws' /proc/mounts; then
        echo "Mounting AWS home directory to /mnt/aws..."
        sshfs ec2-user@y3.138.179.225:/home/ec2-user /mnt/aws
        echo "AWS home directory mounted to /mnt/aws."
    else
        echo "AWS home directory is already mounted."
    fi
}

# Main function
main() {
    check_sshfs
    check_mount_point
    mount_aws_home
}

# Execute the main function
main

