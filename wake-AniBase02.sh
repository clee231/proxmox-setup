#!/usr/bin/env bash

# Check if wakeonlan is installed
if ! command -v wakeonlan &> /dev/null
then
    echo "wakeonlan is not installed. Please install it first."
    exit 1
fi

wakeonlan -i 10.0.0.21 58:47:ca:77:34:a9
wakeonlan -i 10.0.0.22 58:47:CA:77:1D:15
wakeonlan -i 10.0.0.23 58:47:CA:77:1D:D9 

