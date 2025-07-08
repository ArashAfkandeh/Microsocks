#!/bin/bash

# Stopping microsocks service
sudo systemctl stop microsocks
sleep 1

# Disabling microsocks service
sudo systemctl disable microsocks
sleep 1

# Removing microsocks service file
sudo rm -f /etc/systemd/system/microsocks.service
sleep 1

# Reloading systemd daemon
sudo systemctl daemon-reload
sleep 1

# Uninstalling microsocks package
sudo apt remove --purge microsocks -y
sleep 2

# Removing any residual configuration files
sudo apt autoremove -y
sleep 1

# Print uninstallation confirmation
g="\033[1;32m"; r="\033[0m"
w=43
bar() { printf "$1$(printf '─%.0s' $(seq 1 $w))$2\n"; }
line() { printf "│%-${w}s│\n" "$1"; }

echo -e "$g"
bar "┌" "┐"
line "Microsocks has been completely uninstalled."
bar "└" "┘"
echo -e "$r"
