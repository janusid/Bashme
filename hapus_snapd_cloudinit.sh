#!/bin/bash

# Bash script to remove snapd and cloud-init

# Function to check for root privileges
check_root() {
  if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Use sudo."
    exit 1
  fi
}

# Function to remove snapd
remove_snapd() {
  echo "Removing snapd..."
  systemctl stop snapd.service
  systemctl disable snapd.service
  systemctl disable snapd.socket
  systemctl disable snapd.seeded.service
  apt-get purge -y snapd
  rm -rf /var/cache/snapd /snap /var/snap /var/lib/snapd
  echo "snapd removed."
}

# Function to remove cloud-init
remove_cloud_init() {
  echo "Removing cloud-init..."
  apt-get purge -y cloud-init
  rm -rf /etc/cloud /var/lib/cloud
  echo "cloud-init removed."
}

# Function to update and clean up
cleanup_system() {
  echo "Cleaning up..."
  apt-get autoremove -y
  apt-get autoclean -y
  echo "System cleanup complete."
}

# Main function
main() {
  check_root
  remove_snapd
  remove_cloud_init
  cleanup_system
  echo "snapd and cloud-init have been successfully removed."
}

# Execute the main function
main
