@echo off

REM Install Linien server, GUI, and client components
python setup_server.py install
python setup_gui.py install
python setup_client.py install

echo Linien installation completed! 