#!/bin/bash

# Check if a service name is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 service_name"
    exit 1
fi

SERVICE=$1

# Check if the service is active and running
if systemctl is-active --quiet "$SERVICE"; then
    echo "The service '$SERVICE' is running."
else
    echo "The service '$SERVICE' is not running."
fi

exit 0