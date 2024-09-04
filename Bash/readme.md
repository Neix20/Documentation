
# Notes

## Most Commonly Used Bash Commands

```shell
cd          # Change Directory
cp          # Copy Files
mv          # Move Files
ls          # List Files in Directory
ps          # Check Process
rm          # Remove Files
apt         # Install Packages
cat         # Print Out File
tar         # Archive Files
cron        # Schedule Tasks
date        # Show Date
curl        # HTTP Request Method Wrapper
grep        # Fine String
kill        # Kill Process
chmod       # Update Permission of File
mkdir       # Create Directory
rmdir       # Remove Directory
systemctl   # Check Service Status
&           # Run Command in Background
```

## Regex

One Rule to Control All

```shell
s/(.|\n)*?//g
```

## Helpful Scripts

### Get Directory / Folder Size

```shell
du -h --max-depth=1 
```

### Get Total Disk Size

```shell
df -h
lsblk
```

### Mount USB

```shell

## Identify the USB Drive
lsblk
sudo fdisk -l

## Create Mount Point
sudo mkdir /mnt/usb

## Mount USB Drive
sudo mount /dev/sdb1 /mnt/usb

## Unmount USB Drive
sudo umount /mnt/usb
```

### Insert String by Line Number

```shell
sed -i "$line_num"i"$data" ./index.md
```

### Get Line Number

```shell
grep -n "your_text" filename
```

### AWK Basic Syntax

```shell
awk -F'; ' '{ print $1 }'
```

#### AWK For Loop

```shell
cat ./temp/trash.txt | awk '{ split($0, arr, "-"); res = arr[1]; for (i = 2; i <= 5; i++) res = res "-" arr[i]; print res; }'
```

### Generate Cookie

```shell
dd if=/dev/urandom bs=32 count=1 2>/dev/null | base64 | tr -d -- '\n' | tr -- '+/' '-_'; echo
```

### Use Python To Parse File

```shell
echo '{ "name": "Justin" }' | python -c 'import sys, json; print(json.load(sys.stdin)["name"])'
```

### General Bash Syntax

#### For Loop in Bash

```shell
for ((i=0; i<10; i+=1)); do
  echo $i
done
```

#### Arrays in Bash

```shell
ls=("a" "b" "c")
```

#### For Loop Iteratively

```shell
len="${#ls[@]}"
for ((i=0; i<len; i+=1)); do
  echo "${ls[$i]}"
done
```

#### For Of Loop

```shell
for data in ${ls[@]}; do
  echo $data
done
```

#### Length of Array

```shell
echo "${#ls[@]}"
```

#### Functions in Bash

```shell
function sum() {
  a=$1
  b=$2
  res=$((a+b))
  echo $res
}

sum 3 4
```

### File Archiving

#### Zip Files Together

```shell
tar -cf archive.zip ${fileDirname}
7z a archive.zip ${fileDirname}
```

#### Show List of Files in Archive

```shell
tar -tf archive.zip
7z l archive.zip
```

#### Extract Files

```shell
tar -xf archive.zip
7z x archive.zip
```

### Update Bashrc

#### Windows

```shell
vi ./AppData/Local/Programs/Git/etc/bash.bashrc
```

#### MacOS

```shell
vi ~/.zshrc
vi ~/.bashrc
```

#### Linux

```shell
vi ~/.bashrc
```

### SSH

#### Generate Key Pair

```shell
ssh-keygen -t rsa -b 2048 -f <key-name>.pem
```

#### Copy Public Key to Remote Server

```shell
ssh-copy-id -i <key-name>.pem.pub ubuntu@54.173.100.10
```

#### SSH With Public Key Pair

```shell
ssh -i <key-name>.pem ubuntu@54.173.100.10
```

### Get Difference of Folders using diff

```shell
diff -bqr <folder-1> <folder-2>
diff -bqr Dotfiles/ Dotfiles-trash/
```

### Get Difference of files using vim

```shell
vim -d <file-1> <file-2>
vim -d index.md test.md
```

### Use Vim to View Git Logs

```shell
git logs | vim -R -
```

### Check Linux Version

```shell
cat /etc/*release
```

### List All Process Running

```shell
ps -ef
ps aux
```

### Kill Process

```shell
kill -9 <proc-id>
```

### Check All Open Ports

```shell
lsof -i -P -n | grep LISTEN
```

### Check All Network Interface

```shell
tcpdump -D
netstat -i
ifconfig -a
ip addr show
```

### Get Your IP Address

```shell
# Linux / Mac
ip addr

# Windows
ipconfig /all
```

### Tcp Dump

#### Capture Packet

```shell
tcpdump -i enp1s0 -c 5 -w trash.pcap
tcpdump -i 1 -c 5 -w tcpdump.pcap
```

### NetCat

#### Open Socket using netcat

```shell
nc -l -p <port-number>
nc -l -p 1234
```

#### Connect To Open Socket

```shell
nc <ip-address> 1234
nc node01 1234
```

### Encode 64

```shell
echo "Hello, World!" | base64 -w 80
```

### Decode 64

```shell
echo "SGVsbG8sIFdvcmxkIQo=" | base64 -d
```
### List all Ips in your Local Network

```shell
arp -a
```

```shell
# brute force attack
for ip in $(seq 1 254); do 
    ping -c 1 192.168.1.$ip; 
done
```

### Get My Username

```shell
hostname
whoami
```

### Set SSH Password

```shell
sudo passwd <username>
sudo passwd justin
```

### Multi Line Cat File

```shell
cat <<EOF
$(cat ./index.md | head -n $line_num)
- [$date](./logs/$date/index.md)
$(cat ./index.md | tail -n 2)
EOF
```

