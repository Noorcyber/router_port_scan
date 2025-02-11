#!/bin/sh

# Function to echo and then "run" a command
run_cmd() {
    command="$@"
    echo "Running command: $command"
    $command
}

ping_host() {
    run_cmd "ping -c 4 $1"
}

traceroute_host() {
    run_cmd "traceroute $1"
}

get_network_interfaces() {
    run_cmd "ip addr show"
}

get_arp_table() {
    run_cmd "arp"
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

# Traceroute test
traceroute_host "$target_ip"

# Network Interfaces
get_network_interfaces

# ARP Table
get_arp_table

# IPERF Speed Test
echo "Enter the IP address of the iperf server:"
read -r iperf_server_ip
iperf_speed_test "$iperf_server_ip"

# Ping Virtual Clients
echo "Enter the IP address of the router:"
read -r router_ip
echo "Enter a comma-separated list of virtual client IP addresses:"
read -r -a virtual_clients
ping_virtual_clients "$router_ip" "${virtual_clients[@]}"
