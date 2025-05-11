#!/bin/bash

# STEPS
# 1. Activate Dev Mode on Target device
# 2. Find IP of it
# 3. Connect to PC
# 4. adb devices
# 5. adb tcpip 5555
# 6. adb connect IP_ADDR:5555
# 7. adb devices
# 8. Disconnect phone
# 9. scrcpy
# 10. DONE!!!

# Function to prompt user
prompt_user() {
    read -p "$1 [Y/N] (default: Y): " choice
    case "$choice" in
        [Yy]* | "" ) return 0;;  # Default to Y if input is empty
        [Nn]* ) echo "Exiting."; exit 1;;
        * ) echo "Invalid input. Enter Y, N, or press Enter for default."; prompt_user "$1";;
    esac
}

echo "--------------------------------------------------------------------------"

# Step 1: Dev Mode and USB Debugging
# prompt_user "[#] Enable DEV MODE, USB DEBUGGING on device. Done?"
#
#echo ""
#
# Step 2: Note IP Address

# Try to auto-detect via adb first
device_ip=$(adb devices | grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}:5555\b' | cut -d: -f1)

# If not found, use nmap
if [ -z "$device_ip" ]; then
    echo "Scanning network for device on port 5555..."
    device_ip=$(nmap -p 5555 --open -sS 192.168.1.0/24 | grep 'Nmap scan report' | awk '{print $5}' | head -n 1)
fi

# Fallback to manual entry
if [ -z "$device_ip" ]; then
    read -p "Device not found automatically. Enter Device IP: " device_ip
fi

echo "Using device IP: $device_ip"

echo ""

# Step 3: Connect via USB
prompt_user "Connect the device to PC via USB. Connected?"

echo ""

# Step 4: Verify USB Connection
echo "Checking device..."
adb devices
if ! adb devices | grep -q "device$"; then
    echo "No device detected. Ensure USB DEBUGGING is enabled."
    exit 1
fi

echo ""

# Step 5: Switch to TCP/IP Mode
usb_device=$(adb devices | grep -v 'List' | grep -v ':' | awk '{print $1}')
echo "Switching adb to TCP/IP mode (port 5555)..."
adb -s "$usb_device" tcpip 5555 || { echo "Failed to enable TCP/IP mode."; exit 1; }

echo ""

echo "Waiting for device to start TCP/IP..."
sleep 2  # give the device some time to switch

for i in {1..5}; do
    adb connect "$device_ip:5555" && break
    echo "Retrying in 2s..."
    sleep 2
done

if ! adb devices | grep -q "$device_ip:5555"; then
    echo "Wireless connection failed after retries."
    exit 1
fi

# Step 6: Wireless Connection
echo "Connected to $device_ip:5555."

echo ""

# Step 7: Verify Wireless Connection
adb devices
if ! adb devices | grep -q "$device_ip:5555"; then
    echo "Wireless connection failed."
    exit 1
fi

echo ""

# Step 8: Disconnect USB
echo "Disconnect USB cable."
prompt_user "USB disconnected?"

echo ""

# Step 9: Launch scrcpy
echo "--------------------------------------------------------------------------"
echo "Launching scrcpy..."
echo "--------------------------------------------------------------------------"
scrcpy -s "$device_ip:5555" || { echo "Failed to launch scrcpy."; exit 1; }


echo ""

echo "Wireless scrcpy setup complete!"
