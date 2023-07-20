#!/bin/sh

# Function to echo and then "run" a command
run_cmd() {
    command="$@"
    echo "Running command: $command"
}

ping_host() {
    run_cmd "ping -c 4 $1"
}

traceroute_host() {
    run_cmd "traceroute $1"
}

get_network_interfaces() {
    run_cmd "ifconfig"
}

get_arp_table() {
    echo "IP address       HW type     Flags       HW address            Mask     Device"
    echo "192.168.1.1      0x1         0x2         00:11:22:33:44:55     *        eth0"
    echo "192.168.1.100    0x1         0x2         12:34:56:78:90:ab     *        wlan0"
}

iperf_speed_test() {
    run_cmd "iperf3 -R -c $1 -P 16"
}

ping_virtual_clients() {
    router_ip="$1"
    shift
    for client_ip in "$@"; do
        run_cmd "ping -c 4 $client_ip"
    done
}

# Example usage
echo "Enter an IP address:" 
read -r target_ip

# Ping test
ping_host "$target_ip"
echo "Ping Test: (No output in this environment)"

# Traceroute test
traceroute_host "$target_ip"
echo "Traceroute: (No output in this environment)"

# Network Interfaces
get_network_interfaces
echo "Network Interfaces: (No output in this environment)"

# ARP Table
get_arp_table
echo "ARP Table: (No output in this environment)"

# IPERF Speed Test
echo "Enter the IP address of the iperf server:"
read -r iperf_server_ip
iperf_speed_test "$iperf_server_ip"
echo "IPERF Speed Test: (No output in this environment)"

# Ping Virtual Clients
echo "Enter the IP address of the router:"
read -r router_ip
echo "Enter a comma-separated list of virtual client IP addresses:"
read -r -a virtual_clients
ping_virtual_clients "$router_ip" "${virtual_clients[@]}"
echo "Ping Virtual Clients: (No output in this environment)"
