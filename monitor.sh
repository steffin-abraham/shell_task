
#!/bin/bash
# Autor name Steffin 
# date 17/10/2026
# version- V1
# ==========================================
# EC2 SYSTEM MONITORING SCRIPT
# Shell Scripting Assignment
# ==========================================

line="------------------------------------------------------------"

# 1. RUNNING SERVICES
echo "$line"
printf "%-35s %-15s\n" "SERVICE NAME" "STATUS"
echo "$line"

systemctl list-units --type=service --state=running \
--no-legend --no-pager --plain |
awk '{printf "%-35s %-15s\n", $1, $4}'

echo "$line"

# 2. CPU USAGE
echo ""
echo "CPU USAGE"
echo "$line"
printf "%-30s %-20s\n" "METRIC" "VALUE"
echo "$line"

cpu_usage=$(LC_ALL=C top -bn2 -d 0.2 | grep "Cpu(s)" | tail -1 | awk '{print 100 - $8}')

printf "%-30s %-20s\n" "CPU Usage" "${cpu_usage}%"
printf "%-30s %-20s\n" "CPU Cores" "$(nproc)"

echo "$line"

# 3. MEMORY USAGE
echo ""
echo "MEMORY USAGE"
echo "$line"
printf "%-15s %-12s %-12s %-12s\n" "TYPE" "TOTAL" "USED" "AVAILABLE"
echo "$line"

free -h | awk '/^Mem:/ {
printf "%-15s %-12s %-12s %-12s\n", "RAM", $2, $3, $7
}'

echo "$line"

# 4. DISK USAGE
echo ""
echo "DISK USAGE"
echo "$line"
printf "%-15s %-12s %-12s %-12s %-10s\n" "FILESYSTEM" "TOTAL" "USED" "AVAILABLE" "USE%"
echo "$line"

df -h / | awk 'NR==2 {
printf "%-15s %-12s %-12s %-12s %-10s\n", $1, $2, $3, $4, $5
}'

echo "$line"

