# 🧰 Networking & System Utilities Cheat Sheet

> Purpose: Fast troubleshooting of DNS, network, ports, TLS, HTTP, system, containers, and cloud

---

## 🔍 DNS — "Can I resolve the name?"

### Resolve a domain using system DNS

nslookup example.com

### Resolve using a specific DNS server (bypass system resolver)

nslookup example.com 8.8.8.8

### Modern DNS tool (more detailed than nslookup)

dig example.com

### Query a specific DNS server

dig @8.8.8.8 example.com

### Show only resolved IPs (useful in scripts)

dig +short example.com

---

## 🌐 Connectivity & Ports — "Is the port reachable?"

### Check if a TCP port is open (firewall / NSG / SG test)

nc -vz example.com 443

### Check a UDP port (DNS, syslog, etc.)

nc -vzu example.com 53

### TCP check without netcat (bash only)

timeout 3 bash -c "</dev/tcp/example.com/443" && echo "open"

---

## 🌍 HTTP / HTTPS — "Is the service responding?"

### Basic HTTP request

curl <http://example.com>

### Specify a port

curl <http://example.com:8080>

### Verbose output (headers, TLS, redirects, errors)

curl -v <https://example.com>

### Fetch headers only (status code, content-type)

curl -I <https://example.com>

### Follow redirects

curl -L <http://example.com>

---

## 🔐 TLS / SSL — "Is HTTPS / cert broken?"

### Test TLS handshake

openssl s_client -connect example.com:443

### Show full certificate details

openssl s_client -connect example.com:443 </dev/null | openssl x509 -text

---

## 🧭 Routing & Network Path — "Where does it break?"

### Trace network hops (ICMP)

traceroute example.com

### TCP-based traceroute (useful if ICMP blocked)

traceroute -T -p 443 example.com

### Windows equivalent

tracert example.com

---

## 📡 Connectivity & Latency — "Is it slow or dropping?"

### Basic ping

ping example.com

### Limit ping count

ping -c 4 example.com

### Flood ping (root only, stress test)

ping -f example.com

---

## 🔎 Local Ports & Processes — "Is something listening?"

### List listening TCP ports with processes

ss -lntp

### Legacy alternative

netstat -lntp

### Find which process is using a port

lsof -i :8080

---

## 📁 Files & Storage — "Is disk full or mounted?"

### Tree view (1 directory deep)

tree -L 1

### Disk usage (human readable)

df -h

### Folder sizes

du -sh *

---

## 🧠 Processes & Resource Management — "What is running and how do I stop it?"

### Show all processes (full format)

ps -ef

### Show processes for a specific user

ps -ef | grep username

### Find a process by name (exclude grep itself)

ps -ef | grep process_name | grep -v grep

### Show process tree (parent → child)

pstree -p

### Real-time process monitor

top

### Better interactive process viewer

htop

### Show memory usage

free -h

---

## 🔪 Killing Processes — "Make it stop"

### Gracefully stop a process (SIGTERM)

kill <pid>

### Force kill a process (SIGKILL) — last resort

kill -9 <pid>

### Kill by process name (graceful)

pkill process_name

### Kill by process name (force)

pkill -9 process_name

### Kill process listening on a port

kill -9 $(lsof -t -i :8080)

---

## 🚀 Background Processes — "Run and forget"

### Run command in background

command &

### Run command immune to terminal close

nohup command &

### Run command and redirect output to file

nohup command > output.log 2>&1 &

### Explanation:
### > output.log   → redirect stdout
### 2>&1          → redirect stderr to stdout
### &             → run in background

### Check nohup output (default)

cat nohup.out

---

## 📜 Logs & Output Redirection — "Where did the output go?"

### Redirect stdout only

command > output.log

### Redirect stderr only

command 2> error.log

### Redirect both stdout and stderr

command > all.log 2>&1

### Append instead of overwrite

command >> output.log 2>&1

---

## 🧠 Job Control — "Foreground / background"

### Suspend running process

Ctrl + Z

### List background jobs

jobs

### Resume job in background

bg %1

### Resume job in foreground

fg %1

---

## 🧪 Useful One-Liners

### Watch a process continuously

watch -n 1 "ps -ef | grep process_name | grep -v grep"

### Show top memory-consuming processes

ps aux --sort=-%mem | head

### Show top CPU-consuming processes

ps aux --sort=-%cpu | head

---

## 🧰 xargs — "Turn output into arguments"

### Basic usage: pass output as arguments to another command

echo "file1 file2 file3" | xargs rm

### One item per line → one argument

printf "%s\n" file1 file2 file3 | xargs rm

---

## 📦 Containers — "Is Docker behaving?"

### List running containers

docker ps

### Container logs

docker logs <container>

### Exec into container

docker exec -it <container> sh

---

## ☸️ Kubernetes — "Is the pod healthy?"

### List pods

kubectl get pods

### Pod details and events

kubectl describe pod <pod>

### Pod logs

kubectl logs <pod>

### Exec into pod

kubectl exec -it <pod> -- sh

---

## ☁️ Cloud / VM / AKS — "Is cloud networking involved?"

### Check outbound public IP

curl ifconfig.me

### Azure Instance Metadata Service (IMDS)

curl -H Metadata:true \
"http://169.254.169.254/metadata/instance?api-version=2021-02-01"

---

## 🛠️ Misc Utilities — "Daily glue commands"

### Today's date (YYYYMMDD)

date +%Y%m%d

### List environment variables

env | sort

### Show network interfaces and IPs

ip a

---

## 🧠 Mental Debug Flow — "Do this in order"

### 1. DNS

nslookup example.com

### 2. Port / Firewall

nc -vz example.com 443

### 3. TLS

openssl s_client -connect example.com:443

### 4. HTTP

curl -v <https://example.com>

### 5. Application logs

kubectl logs <pod> | docker logs <container>

---
