#!/bin/bash

# Path to your venv
VENV="/Users/jeffreyli/Desktop/Ni Lab/oldlinienvenv"

# Install dependent packages
"$VENV/bin/python" -m pip install --no-deps -r requirements_gui

# Install Linien server, GUI, and client components
"$VENV/bin/python" setup_server.py install
"$VENV/bin/python" setup_gui.py install
"$VENV/bin/python" setup_client.py install

echo "Linien installation completed!"
