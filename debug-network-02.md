# Local Network Debugging Cheat Sheet

**Tools: nmap & arp**

## 1. Find Devices on Your Local Network

### Discover live hosts (ARP scan – fastest & safest on LAN)
```bash
sudo nmap -sn 192.168.1.0/24
```
- Uses ARP (no port scan)
- Best first command to see "who's here"

### Explicit ARP-only scan
```bash
sudo nmap -sn -PR 192.168.1.0/24
```
- Forces ARP ping
- Useful if ICMP is blocked

## 2. See IP ↔ MAC Address Mapping

### Show ARP table (Linux / macOS)
```bash
arp -a
```

### Show ARP table with numeric output
```bash
arp -an
```

### Filter ARP entry for a specific IP
```bash
arp -an | grep 192.168.1.10
```

## 3. Identify What Services a Host Is Running

### Scan common ports on a specific host
```bash
nmap 192.168.1.10
```

### Scan all ports (slower but thorough)
```bash
nmap -p- 192.168.1.10
```

### Detect service versions
```bash
nmap -sV 192.168.1.10
```

## 4. OS & Device Fingerprinting

### Attempt OS detection
```bash
sudo nmap -O 192.168.1.10
```

### OS + services + traceroute (aggressive scan)
```bash
sudo nmap -A 192.168.1.10
```
⚠️ **Use `-A` carefully on production networks**

## 5. Scan Entire Subnet for Open Ports

### Common ports across the subnet
```bash
nmap 192.168.1.0/24
```

### Check a specific port on all devices (e.g., SSH)
```bash
nmap -p 22 192.168.1.0/24
```

### Check multiple ports
```bash
nmap -p 22,80,443 192.168.1.0/24
```

## 6. Debug "Why Can't I Connect?"

### Check if host is reachable (ARP + ICMP)
```bash
nmap -sn 192.168.1.10
```

### Verify a port is open
```bash
nmap -p 5432 192.168.1.10
```

### Check TCP connection without full scan
```bash
nmap -Pn -p 80 192.168.1.10
```
- Skips host discovery
- Useful when ping is blocked

## 7. Detect Duplicate IP or ARP Issues

### Watch ARP changes live
```bash
watch -n 1 arp -an
```

### Look for duplicate MAC addresses
```bash
arp -an | sort | uniq -d
```

## 8. Vendor / Device Type Detection

### Show MAC vendor info
```bash
sudo nmap -sn 192.168.1.0/24
```
Nmap will print vendor info (Apple, Intel, Raspberry Pi, etc.)

## 9. Bonus: Quick "Who Is This IP?"
```bash
sudo nmap -sn -n 192.168.1.10
arp -an | grep 192.168.1.10
```
- First line: is it alive?
- Second line: what MAC owns it?

## 10. Safe Defaults for Local Debugging

- ✅ Prefer `-sn` for discovery
- ✅ Use `-p` for targeted port checks
- ⚠️ Avoid `-A` unless you need deep inspection
- ℹ️ ARP scans are LAN-only (won't work across routers)

---

## WiFi Management (NetworkManager)

### List all WiFi connections
```bash
nmcli dev wifi
```

### Connect to WiFi with username and password
```bash
nmcli device wifi connect <wifi-name> <wifi-password>
```

**Example:**
```bash
nmcli device wifi connect neix-home@unifi xxx888
```

### Show WiFi password
```bash
nmcli dev wifi show-password
```