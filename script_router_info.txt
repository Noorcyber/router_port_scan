#!/bin/sh

ping_host() {
    if [ "$(uname)" = "Darwin" ]; then
        ping -c 4 "$1"
    else
        ping -n 4 "$1"
    fi
}

traceroute_host() {
    if [ "$(uname)" = "Darwin" ]; then
        traceroute "$1"
    else
        traceroute -m 4 "$1"
    fi
}

get_network_interfaces() {
    if [ "$(uname)" = "Darwin" ]; then
        ifconfig
    else
        ipconfig
    fi
}

get_arp_table() {
    if [ "$(uname)" = "Darwin" ]; then
        arp -a
    else
        arp
    fi
}

iperf_speed_test() {
    iperf3 -R -c "$1" -P 16
}

ping_virtual_clients() {
    router_ip="$1"
    shift
    ping_results=""
    for client_ip in "$@"; do
        ping_output=$(ping_host "$client_ip")
        ping_results="${ping_results}\n${client_ip}: ${ping_output}"
    done
    echo "$ping_results"
}

# Example usage
echo "Enter an IP address:" 
read -r target_ip  # Replace with your router/firewall IP address

# Ping test
ping_output=$(ping_host "$target_ip")
echo "Ping Test:"
echo "$ping_output"

# Traceroute test
traceroute_output=$(traceroute_host "$target_ip")
echo "Traceroute:"
echo "$traceroute_output"

# Network Interfaces
network_interfaces_output=$(get_network_interfaces)
echo "Network Interfaces:"
echo "$network_interfaces_output"

# ARP Table
arp_table_output=$(get_arp_table)
echo "ARP Table:"
echo "$arp_table_output"

# IPERF Speed Test
echo "Enter the IP address of the iperf server:"
read -r iperf_server_ip
iperf_output=$(iperf_speed_test "$iperf_server_ip")
echo "IPERF Speed Test:"
echo "$iperf_output"

# Ping Virtual Clients
echo "Enter the IP address of the router:"
read -r router_ip
echo "Enter a comma-separated list of virtual client IP addresses:"
read -r -a virtual_clients
ping_results=$(ping_virtual_clients "$router_ip" "${virtual_clients[@]}")
echo "Ping Virtual Clients Results:"
echo "$ping_results"
