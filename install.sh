#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install necessary packages if they are not already installed
echo "Checking and installing prerequisites..."
sudo apt update -y

if ! command_exists curl; then
    echo "curl not found. Installing curl..."
    sudo apt install curl -y
    if ! command_exists curl; then
        echo "Failed to install curl. Please install it manually and re-run the script."
        exit 1
    fi
fi

if ! command_exists wget; then
    echo "wget not found. Installing wget..."
    sudo apt install wget -y
    if ! command_exists wget; then
        echo "Failed to install wget. Please install it manually and re-run the script."
        exit 1
    fi
fi

# Check if terminal supports colors
if [ -t 1 ] && command -v tput >/dev/null 2>&1 && tput colors >/dev/null 2>&1; then
    y=$(tput setaf 3)  # Yellow for input prompts
    r=$(tput sgr0)     # Reset color
else
    y=""  # Disable colors if not supported
    r=""
fi

# Check if arguments are provided and handle port interactively if empty
if [ "$#" -eq 0 ]; then
    # No arguments provided, enter interactive mode
    echo "Entering interactive mode..."
    read -p "${y}Enter port number: ${r}" PORT
    read -p "${y}Enter username (optional, press Enter to skip): ${r}" USERNAME
    if [ -n "$USERNAME" ]; then
        read -p "${y}Enter password: ${r}" PASSWORD
        echo
    fi
elif [ "$#" -eq 1 ] || [ "$#" -eq 3 ]; then
    # Arguments provided, assign them
    PORT=$1
    USERNAME=$2
    PASSWORD=$3

    # If port is empty or invalid, prompt interactively
    if [ -z "$PORT" ] || ! [[ "$PORT" =~ ^[0-9]+$ ]] || [ "$PORT" -lt 1 ] || [ "$PORT" -gt 65535 ]; then
        echo "Port is empty or invalid. Entering interactive mode for port..."
        read -p "${y}Enter port number: ${r}" PORT
    fi
else
    # Incorrect number of arguments
    echo "Error: Incorrect number of arguments."
    echo "Usage (Interactive): $0"
    echo "Usage (Port only): $0 <port_number>"
    echo "Usage (Port, User, Pass): $0 <port_number> <username> <password>"
    exit 1
fi

# Validate port number
if ! [[ "$PORT" =~ ^[0-9]+$ ]] || [ "$PORT" -lt 1 ] || [ "$PORT" -gt 65535 ]; then
    echo "Error: Invalid port number '$PORT'. Please enter a number between 1 and 65535"
    exit 1
fi

# Validate username and password
if [ -n "$USERNAME" ] && [ -z "$PASSWORD" ]; then
    echo "Error: Password must be provided if username is specified"
    exit 1
fi

# Installing microsocks
echo "Installing microsocks..."
if ! command_exists microsocks; then
    sudo apt install microsocks -y
    if ! command_exists microsocks; then
        echo "Failed to install microsocks. Please check your system and try again."
        exit 1
    fi
else
    echo "Microsocks is already installed."
fi
sleep 2

# Creating microsocks service file with provided port and optional credentials
EXEC_START="/usr/bin/microsocks -p $PORT"
if [ -n "$USERNAME" ] && [ -n "$PASSWORD" ]; then
    EXEC_START="$EXEC_START -u $USERNAME -P $PASSWORD"
fi

cat << EOF | sudo tee /etc/systemd/system/microsocks.service
[Unit]
Description=MicroSocks SOCKS5 Proxy
After=network.target

[Service]
ExecStart=$EXEC_START
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF
sleep 1

# Reloading systemd daemon
sudo systemctl daemon-reload
sleep 1

# Enabling microsocks service
sudo systemctl enable microsocks
sleep 1

# Starting microsocks service
sudo systemctl start microsocks
sleep 2

# Checking microsocks service status
sudo systemctl status microsocks

# Print IP, PORT, and credentials if provided
ip=$(ip -4 a | grep -oP '(?<=inet\s)\d+(.\d+){3}' | grep -v 127 | head -1)
g="\033[1;32m"; r="\033[0m"
w=29
bar() { printf "$1$(printf '─%.0s' $(seq 1 $w))$2\n"; }
line() { printf "│%-${w}s│\n" "$1"; }

echo -e "\nYour Socks Info:$g"
bar "┌" "┐"
line "IP:   $ip"
bar "├" "┤"
line "Port: $PORT"
if [ -n "$USERNAME" ] && [ -n "$PASSWORD" ]; then
    bar "├" "┤"
    line "Username: $USERNAME"
    bar "├" "┤"
    line "Password: $PASSWORD"
fi
bar "└" "┘\n$r"

# Print socks account links with descriptions
echo -e "SOCKS5 Proxy Link:"
if [ -n "$USERNAME" ] && [ -n "$PASSWORD" ]; then
    echo -e "${g}socks5://$USERNAME:$PASSWORD@$ip:$PORT${r}"
else
    echo -e "${g}socks5://$ip:$PORT${r}"
fi

echo -e "\nTelegram Proxy Link:"
if [ -n "$USERNAME" ] && [ -n "$PASSWORD" ]; then
    echo -e "${g}https://t.me/socks?server=$ip&port=$PORT&user=$USERNAME&pass=$PASSWORD${r}"
else
    echo -e "${g}https://t.me/socks?server=$ip&port=$PORT${r}"
fi
echo -e "$r"
