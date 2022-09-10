echo "Now Installing TailScale VPN"

curl -fsSL https://tailscale.com/install.sh | sh

# disable ipv6; only have to do this once

sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1

sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1

# run the tailscale daemon

sudo tailscaled


