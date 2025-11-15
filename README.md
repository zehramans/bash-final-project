# █░░ █▀▀█ █▀▀▀ █▀▀▀ █▀▀ █░█ 
# █░░ █░░█ █░▀█ █░▀█ █▀▀ ▄▀▄ 
# ▀▀▀ ▀▀▀▀ ▀▀▀▀ ▀▀▀▀ ▀▀▀ ▀░▀

# loggex

**loggex** is a simple command-line tool to analyze **Apache** and **SSH** log files.  
It prints out the IP addresses that occur the most and detects potential **brute-force** or **SQL injection** attacks.

---
## 📦 Usage

### Basic syntax
| Flag | Description |
|------|-------------|
| `-f <file>` | Specify log file to analyze |
| `-F <format>` | Specify log file format (`apache` or `ssh`) |
| `-d <type>` | Detection type (`brute` or `injection`) |
