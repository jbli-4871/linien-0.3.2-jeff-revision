@echo off
REM Path to your venv (edit this!)
set VENV=C:\Users\jeffreyli\Desktop\Ni Lab\oldlinienvenv

REM Install dependent packages
"%VENV%\Scripts\python.exe" -m pip install --no-deps -r requirements_gui

REM Install Linien server, GUI, and client components
"%VENV%\Scripts\python.exe" setup_server.py install
"%VENV%\Scripts\python.exe" setup_gui.py install
"%VENV%\Scripts\python.exe" setup_client.py install

echo Linien installation completed!