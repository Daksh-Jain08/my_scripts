#!/bin/bash

# Function to disconnect Bluetooth device
disconnect_device() {
    # Get the MAC address of the connected device
    DEVICE_MAC=$(bluetoothctl info | grep 'Device' | awk '{print $2}')
    
    if [ -n "$DEVICE_MAC" ]; then
        # Disconnect the device
        echo "Disconnecting device with MAC address $DEVICE_MAC..."
        bluetoothctl << EOF
disconnect $DEVICE_MAC
EOF
        echo "Device disconnected."
    else
        echo "No device is currently connected."
    fi
}

# Check if Bluetooth is available
if ! [ -x "$(command -v bluetoothctl)" ]; then
  echo 'Error: Bluetooth is not available.' >&2
  exit 1
fi

# Disconnect the device
disconnect_device
