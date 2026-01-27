#!/bin/bash

printf "| %-5s | %-20s | %-5s | %-7s |\n" "STT" "VPS ID" "vCPU" "CPU %"
printf "|-%-5s-|-%-20s-|-%-5s-|-%-7s-|\n" "-----" "--------------------" "-----" "-------"

i=1

for vm in $(virsh list --name); do
    [ -z "$vm" ] && continue

    # Lấy vCPU
    vcpu=$(virsh dominfo "$vm" 2>/dev/null | awk -F': +' '/CPU.s/ {print $2}')
    [ -z "$vcpu" ] && vcpu=1

    # Lấy PID QEMU của VM
    pid=$(virsh dominfo "$vm" 2>/dev/null | awk -F': +' '/PID/ {print $2}')
    [ -z "$pid" ] && continue

    # %CPU thô (có thể >100%)
    pcpu=$(ps -p "$pid" -o %cpu= 2>/dev/null | tr -d ' ')
    [ -z "$pcpu" ] && pcpu=0

    # CPU trung bình trên mỗi core
    usage=$(awk -v c="$pcpu" -v v="$vcpu" 'BEGIN {
        if (v < 1) v = 1;
        u = c / v;
        if (u > 100) u = 100;
        printf "%.0f", u
    }')

    printf "| %-5s | %-20s | %-5s | %-6s%% |\n" "$i" "$vm" "$vcpu" "$usage"
    i=$((i+1))
done
