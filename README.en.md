<div style="text-align: center;">
    <a href="/README.en.md"><img src="https://flagicons.lipis.dev/flags/4x3/gb.svg" alt="English" width="20"/> English</a> | 
    <a href="/README.md"><img src="https://flagicons.lipis.dev/flags/4x3/ir.svg" alt="فارسی" width="20"/> فارسی</a>
</div>
<br><br>

# Easy Microsocks Proxy Installation
This project installs the Microsocks SOCKS5 proxy on your Linux system with a single command.

# Prerequisites

- A Linux system with sudo access.
- The apt package manager (used in Debian/Ubuntu-based distributions).

# Installation
Run the following command for interactive installation:

```bash 
bash <(curl -sSL https://raw.githubusercontent.com/ArashAfkandeh/Microsocks/main/install.sh)
```

You will be prompted for the following values:

- **Port (required):** The port on which the SOCKS5 proxy will listen (e.g., 1080).
- **Username (optional):** If you want to secure your proxy with a username, enter it here. Press Enter to skip.
- **Password (optional):** If a username is provided, enter its password.

**Alternatively, you can use input arguments:**

Without identity:
```bash 
bash <(curl -sSL https://raw.githubusercontent.com/ArashAfkandeh/Microsocks/main/install.sh) 'PORT' 'USERNAME' 'PASSWORD'
```

With authentication:
```bash
bash <(curl -sSL https://raw.githubusercontent.com/ArashAfkandeh/Microsocks/main/install.sh) '1080' 'admin' '12345'
```

**Note:** The first argument (port PORT) is required; otherwise, it will fall back to interactive mode.

# Usage
After the script completes, it will display the SOCKS5 proxy details as follows:

<div style="display: flex; justify-content: center;">
    <img src="https://github.com/ArashAfkandeh/Microsocks/blob/main/Preview.jpg" alt="Preview" style="width: 400px; height: auto; border-radius: 10px;">
</div>

- **IP Address:** Your server's public IP address.
- **Port:** The port you specified during installation.
- **Username (if set):** The username you configured.
- **Password (if set):** The password you configured.

You can configure your applications (such as web browsers, messaging apps) with these details to use the SOCKS5 proxy.

# Uninstallation
To completely remove the microsocks proxy and its configuration, run the following command in your terminal:

```bash
bash <(curl -sSL https://raw.githubusercontent.com/ArashAfkandeh/Microsocks/main/uninstall.sh)
```
