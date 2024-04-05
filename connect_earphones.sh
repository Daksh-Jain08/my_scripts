#!/bin/bash

EARPHONES_ADDRESS="<Your_Device_Mac>"
EARPHONES_NAME="<Your_Device_Name>"

if ! [ -x "$(command -v bluetoothctl)" ]; then
  echo 'Error: Bluetooth is not available.' >&2
  exit 1
fi

if ! bluetoothctl show | grep -q "Powered: yes"; then
  echo "Bluetooth is off. Turning it on..."
  rfkill unblock bluetooth
  sleep 2
fi

echo "Connecting to $EARPHONES_NAME..."

already_connected=$(bluetoothctl info | grep "Device $EARPHONES_ADDRESS")

if ! [ -n "$already_connected" ]; then
  bluetoothctl connect "$EARPHONES_ADDRESS"
  sleep 2
else
  echo "The bluetooth is already connected to the $EARPHONES_NAME"
  exit
fi

connected=$(bluetoothctl info | grep "Device $EARPHONES_ADDRESS")

if [ -n "$connected" ]; then
  echo "connected to $EARPHONES_NAME."
else
  echo "Failed to connect to $EARPHONES_NAME."
fi
