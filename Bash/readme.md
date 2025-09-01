
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
xargs       # Pass Output to other commands as Parameters
tee         # Write to file in midst of long commands
nohup       # Allows for a process to live when the terminal gets killed
```

## Regex

One Rule to Control All

```shell
s/(.|\n)*?//g
```

## Helpful Scripts

### Nohup Command

- [Difference between "&" and "nohup"](https://stackoverflow.com/questions/13338870/what-does-at-the-end-of-a-linux-command-mean)

```shell
# Run a shell script that can live beyond the terminal (Current Session):
path/to/script.sh &

# Run a shell script that can live beyond the terminal (After SSH Session):
nohup path/to/script.sh &

# Write Output of Command
nohup ping google.com > output.txt &

# Pipe StdErr and StdOutput to Same Place
nohup ping google.com > output.txt 2>&1 &

# Echo Process Id to File
echo $! > test.pid
```
#### List all Services Started by Nohup

```shell

# List All Background Processes
# Includes "&" and "nohup"
jobs -l

# To Kill Services
kill -9 <pid>
```

### Xargs Command

`xargs` command is to pass output to other command as new parameters

```shell
kubectl get pod | grep 'frontend' | awk '{ print $1 }' | xargs kubectl logs

# Normally to get the log, we need to write like this
kubectl logs <pod-name>
kubectl logs xxx-frontend-xxx-xxx

# But, to copy paste this pod name is a bit redundant.
# Therefore, we will use pod to grep the keyword 'frontend', and then pass it to kubectl logs as parameter

# Kill Process ID using jobs -l
jobs -l | awk '{ print $2 }' | xargs kill -9
```

### Tee Command

`tee` command is to write into a file, in the midst of it, while still pipe it to other output

command | tee [option] file | command

```shell
# To tee stdout to the terminal, and also pipe it into another program for further processing:
ls | tee /dev/tty | xargs printf "\033[1;34m%s\033[m\n"
```

### SCP Tutorial

```shell
scp file user@host:/path/to/file                        # copying a file to the remote system using scp command
scp user@host:/path/to/file /local/path/to/file         # copying a file from the remote system using scp command
scp file1 file2 user@host:/path/to/directory            # copying multiple files using scp command
scp -r /path/to/directory user@host:/path/to/directory  # Copying an entire directory with scp command
```

### Run Every Command without prompt

```shell
sudo apt install <process> -y
```

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

- <https://linuxconfig.org/how-to-partition-usb-drive-in-linux>
- <https://askubuntu.com/questions/11840/how-do-i-use-chmod-on-an-ntfs-or-fat32-partition>

```shell

## Identify the USB Drive
lsblk
sudo fdisk -l

## Create Mount Point
sudo mkdir /mnt/usb

## Mount USB Drive
sudo mount /dev/sdb1 /mnt/usb
sudo mount -t ntfs -o rw,auto,user,fmask=0022,dmask=0000 /dev/whatever /mnt/whatever

## Unmount USB Drive
sudo umount /mnt/usb

### Format Disk to FAT32
sudo mkfs.vfat /dev/[device_name]

### Verify Disks
sudo fsck /dev/[device_name]
```

### Insert String by Line Number

```shell
sed -i "$line_num"i"$data" ./index.md
```

### Print out the Nth Line

```shell
sed -n '<number>p'
jobs -l | sed -n '2p'
```

### Print Line By Line Number

```shell
sed -n '2p' filename #get the 2nd line and prints the value (p stands for print)

sed -n '1,2p' filename #get the 1 to 2nd line and prints the values

sed -n '1p;2p;' filename #get the 1st and 2nd line values only
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

### Check for Which Ports is Being Monitored

```shell
netstat -an
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

### SystemCtl

#### Check Process Status

```shell
sudo systemctl status <process-name>
```

#### Restart Process

```shell
sudo systemctl restart <process-name>
```

#### Start Process

```shell
sudo systemctl start <process-name>
```

#### Stop Process

```shell
sudo systemctl stop <process-name>
```

### Check If Port is Open from External Computer

```shell
timeout 3 nc -vz <ip-address> <port-num>
timeout 3 nc -vz 192.168.0.3 1234
```

### Get IP of Websites

```shell
nslookup <website>
dig <website>

nslookup google.com
dig google.com
```

### Setup HTTP SSL

```shell
sudo snap install core; sudo snap refresh core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo certbot certonly --nginx
```

### Setup SSH

```shell
sudo vim /etc/ssh/sshd_config
sudo service ssh restart
```

### OpenSSL

```shell

# Check CSR Locally
openssl req -in <csr-location> -noout -text

# Check Private Key
openssl rsa -in privateKey.key -check

# Check Certificate
openssl x509 -in certificate.crt -text -noout

# Check PKCS#12 File
openssl pkcs12 -info -in keyStore.p12

# Generate CSR
openssl req -out CSR.csr -new -newkey rsa:2048 -nodes -keyout privateKey.key
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout cert.key -out cert.crt -subj "/CN=world.universe.mine/O=world.universe.mine"

# Generate Self-Signed Certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout privateKey.key -out certificate.crt

# Generate a CSR for an existing private key
openssl req -out CSR.csr -key privateKey.key -new

# Generate a CSR based on existing certificate
openssl x509 -x509toreq -in certificate.crt -out CSR.csr -signkey privateKey.key

# Remove Passphrase from Private Key
openssl rsa -in privateKey.pem -out newPrivateKey.pem

# Generate a private Key
openssl genrsa -aes256 -out <domain>/<program/project>/<site_name>/<site_name>.<domain>.key 2048

# OpenSSL Read CSR
openssl x509 -noout -text -in <domain>.csr

# Generate a CSR

export subject_alt_name=DNS:<site_name>.<domain>,DNS:<site-sub/internaldns>

openssl req -config openssl.cnf -key <domain>/<program/project>/<site_name>/<site_name>.<domain>.key -reqexts v3_req_server -new -sha256 -out <domain>/<program/project>/<site_name>/<site_name>.<domain>.csr
```

### FFMpeg

#### Split Video Into Frame

```shell
ffmpeg -ss 00:00:00 -t 00:30:00 -i trans.mp4 -r 1 img/image%d.png
```

#### Combine Frame into Video

```shell
ffmpeg -framerate 5 -y -i img/image%d.png -c:v h264 -r 30 -pix_fmt yuv420p output.mp4
```

#### Merge Image And Audio

```shell
ffmpeg -i gift.jpg -i hari_raya.mp3 overlay_video.mp4
```

#### Merge Video And Audio

```shell
ffmpeg -i video/hoho.mp4 -i audio/mDay_I.mp3 -shortest output.mp4
```

#### Overlay Video And Green Screen Video

```shell
ffmpeg -i green_screen.mp4 -i overlay_video.mp4 -filter_complex "[0:v]chromakey=0x50f433:0.1:0.2[ckout];[1:v][ckout]overlay=0:0" output.mp4
```

#### Convert Green Screen Video into Transparent Video

```shell
ffmpeg -i video/green_screen.mp4 -i img/trans.png -filter_complex "[0:v]chromakey=0x50f433:0.1:0.2[ckout];[1:v][ckout]overlay=0:0" -f gif output.gif
```

#### Extract Audio From Video

```shell
ffmpeg -i input_video.mp4 -q:a 0 -map a output_audio.mp3
```

#### Crop Video To Timestamp (E.g. 10 Seconds)

```shell
ffmpeg -i input_video.mp4 -ss 00:00:00 -t 00:00:10 -c copy output_video.mp4
```

#### Crop Audio To Timestamp (E.g. 10 Seconds)

```shell
ffmpeg -i input_audio.mp3 -ss 00:00:00 -t 00:00:10 -c copy output_audio.mp3
```

### Youtube DL

#### Installing Youtube-DL

```shell
pip install --upgrade --force-reinstall git+https://github.com/ytdl-org/youtube-dl.git
```

#### Download Youtube Video

```shell
youtube-dl <https://www.youtube.com/watch?v=E-PrhaMCIks> -f mp4
```

#### Download Youtube Audio

```shell
youtube-dl <https://www.youtube.com/watch?v=esh8mNoPxGE> -x --audio-format mp3
```

### Image Magick

#### Get Image Info

```shell
magick identify 1705890706514.jpg
```

#### Resize Image to Specific Size

```shell
convert 1705890706514.jpg -resize 1290x2796! new.jpg
```

#### Crop Image by Specific Coordinates

```shell
convert input_image.jpg -crop widthxheight+x+y output_image.jpg
convert input_image.jpg -crop 100x50+10+20 output_image.jpg
```

#### Convert Image Format

```shell
magick input.webp output.jpg
```

#### Remove Background

```shell
convert image.png -background white -alpha remove -alpha off white.png
```

```shell
function resize_img() {
  convert $1 -resize 1290x2796! $1
}

function crop_image_android() {
  read w h < <(identify -format "%w %h" $1)
  convert $1 -crop "$w"x$((h*91/100))+0+$((h*4/100)) $1
}

function crop_half_image() {
  convert ~/Downloads/Yatu\ Lite/Multiple.jpg -crop 50%x100% +repage ~/Downloads/Yatu\ Lite/output%d.jpg
}
```

### Wifi

#### Linux

- <https://askubuntu.com/questions/377687/how-do-i-connect-to-a-wifi-network-using-nmcli>
- <https://askubuntu.com/questions/156861/find-the-password-for-the-currently-connected-wireless-network>

```shell
# List all Wifi Connections
nmcli dev wifi

# Connect to Wifi With Username and password
nmcli device wifi connect <wifi-name> <wifi-password>
nmcli device wifi connect neix-home@unifi xxx888

# Show Password
nmcli dev wifi show-password
```

#### Windows

- <https://superuser.com/questions/1157209/how-to-connect-to-a-wifi-using-cmd-only>
- <https://superuser.com/questions/1604729/connecting-to-wifi-network-from-command-prompt>

```shell
# List all Wifi Connections
netsh wlan show networks

# Create a Wifi Profile
netsh wlan show profiles

# Connect to Wifi With Username and Password (Requires Profile)
netsh wlan connect ssid=<ssid-name> name=<profile-name> interface="<interface-name>"

# Show Password
netsh wlan show profile name="<profile-name>" key="clear"
netsh wlan show profile name="neix_deco" key="clear"
```

#### MacOs

- <https://sharmank.medium.com/how-to-connect-to-wifi-using-mac-os-command-line-3a76c2e6669c>
- <https://apple.stackexchange.com/questions/176119/how-to-access-the-wi-fi-password-through-terminal>

```shell
# List All Wifi Connections
/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s

# Connect to Wifi With Username and Password
networksetup -setairportnetwork en0 <SSID_OF_NETWORK> <PASSWORD>
networksetup -setairportnetwork en0 "$1" "$2"

# Show Password
security find-generic-password -ga <wifi-name> | grep "password:"
security find-generic-password -ga neix_deco | grep "password:"
```
