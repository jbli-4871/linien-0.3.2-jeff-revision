LINIEN-RELOCK
======

<img align="right" src="https://raw.githubusercontent.com/hermitdemschoenenleben/linien/master/docs/icon.png" width="20%">

This is a copy of [linien v0.3.2](https://github.com/linien-org/linien/tree/v0.3.2) that's been modified to:
- fix package dependency issues
- include a "Relock" mode that uses the RedPitaya to control a Vescent Lockbox via a TTL pulse through Analog Output 2
Please refer to the main [linien v0.3.2 repo](https://github.com/linien-org/linien/tree/v0.3.2) for more details about the base package.

Installation Instructions
---------------

### 1. Setting up a virtual environment

Because the original linien v0.3.2 package depends on several packages that have since been updated/deprecated, the safest way to install linien-relock on a new computer is to create a virtual environment (venv). This prevents version compatibility errors between linien's required packages and any packages you might already have installed on your computer. 

Before creating the venv, check if you have Python 3.12 installed. Linien will not run on newer version of Python. Open a command window and type
```bash
python3.12 --version
```

If this does not return something like "Python 3.12.x", you will need to install Python 3.12. You can do this by visiting the [official Python website](https://www.python.org/downloads/release/python-3127/) and downloading the installer that's relevant for your operating system. It doesn't matter which version of Python 3.12 you install, so just install the latest stable release (the one in the link). Remember to click the option to add this new Python to your PATH if you're using Windows.

Now, in the same command window type
```bash
python3.12 --version
```

If you get a result like "Python 3.12.x" then you've successfully installed the package. 

Next, use this Python version to create a virtual environment to house all of the linien packages
```bash
python3.12 -m venv linienvenv
```

Attach this venv to your command window. On Mac OS:
```bash
source linienvenv/bin/activate
```

on Windows Command Prompt:
```bash
linienvenv\Scripts\activate.bat
```

After venv activation you should see your prompt line have a "(linienvenv)" before your file location.

Note where your virtual environment is by running this command (again) in the same command window that you just installed your virtual environment:
```bash
where python
```

Your output might contain multiple lines, but the first line should point to your virtual environment location: something like */Users/jeffreyli/Desktop/linienvenv/bin/python*

### 2. Installing linien-relock on your computer: 

Now you are (finally!) ready to install linien. First, download or clone this Github repo. 

If you are on **Mac OS** open the *install_linien.sh* file in a text editor. The fourth line says
```bash
VENV="/Users/jeffreyli/Desktop/Ni Lab/linienvenv"
```

Modify this to the path for your virtual environment that you recorded in step 1 of the installation. With this complete, in your terminal run the following command:
```bash
./install_linien.sh
```

This should install linien-relock and all of its necessary dependencies. 

If are on **Windows** open the *install_linien.bat* file in a text editor. The fourth line says:
```bash
VENV=C:\Users\jeffreyli\Desktop\Ni Lab\linienvenv
```

Modify this to the path for your virtual environment that you recorded in step 1 of the installation. With this complete, in your terminal run the following command:
```bash
./install_linien.bat
```

### 3. Installing linien-relock on your Red Pitaya:

First, install the Red Pitaya OS 1.04-28 found on the [Red Pitaya website](https://www.python.org/downloads/release/python-3127/) with installation instructions at the bottom of the page. Note down the host name of the Red Pitaya. It should be something of the form "RP-XXXXXX.LOCAL/" written on the board above the ethernet port. Afterwards, you should connect the Red Pitaya via ethernet to a router that has internet access. There are ways to set up linien on the Red Pitaya without internet, but they're much more painful.

If the Red Pitaya has internet access: In your terminal running the virtual environment, run 
```bash
python
```

to create a Python screen and run the following two lines.
```python
from linien.gui.app import run_application
run_application()
```

This will bring up the GUI. You can click the "New device" button and add your device's hostname in the instructed box. Once added, click on the hostname that corresponds to your Red Pitaya in the main window. This will automatically connect to the Red Pitaya and install the relevant files/packages from this Github repo over internet.


Physical setup
--------------

The default setup looks like this:

![image](https://raw.githubusercontent.com/hermitdemschoenenleben/linien/master/docs/setup.png)

You can also configure linien for different setups, e.g. if you want to
have the modulation frequency and the control on the same output. Additionally, it is possible to set up a slow integrator on ANALOG OUT 0 (0 V to 1.8 V).

![image](https://raw.githubusercontent.com/hermitdemschoenenleben/linien/master/docs/explain-pins.png)

Using the application
---------------------

### First run: connecting to the RedPitaya

After launching Linien you should supply details of your RedPitaya. Its host address is usually given by <pre>rp-<b>XXXXXX.local</b></pre>, where **XXXXXX** are the last 6 digits of the device's MAC address. You will find them on a sticker on the ethernet port:

![image](https://raw.githubusercontent.com/hermitdemschoenenleben/linien/master/docs/mac.jpg)

Default value for user name and password is `root`.

When connecting to a RedPitaya for the first time, the Linien offers you to install the server component. Please note that this requires internet access on the RedPitaya (LAN access is not sufficient).

Once server libraries are installed, Linien will automatically run the server and connect to it. There's no need ever to start or stop anything on the server manually as the client takes care of this.

The server now operates autonomously: closing the client application doesn't have any influence on the lock status. You may also start multiple clients connecting to the same server.

### Setting things up

The first thing to set up is the configuration of input and output signals:

![image](https://raw.githubusercontent.com/hermitdemschoenenleben/linien/master/docs/explain-pins.png)

Head over to *Modulation, Ramp & Spectroscopy* and set modulation frequency and amplitude. Once your setup is working, you should see something like this:

![image](https://raw.githubusercontent.com/hermitdemschoenenleben/linien/master/docs/spectrum.jpg)

The bright red line is the demodulated spectroscopy signal. The dark red area is the signal strength obtained by [iq demodulation](https://en.wikipedia.org/wiki/In-phase_and_quadrature_components), i.e. the demodulation signal obtained when demodulating in phase at this point.

### Optimization of spectroscopy parameters using machine learning

Linien may use machine learning to maximize the slope of a line. As for the autolock, click and drag over the line you want to optimize. Then, the line is centered and the optimization starts. Please note that this only works if initially a distinguished zero-crossing is visible.

![image](https://raw.githubusercontent.com/hermitdemschoenenleben/linien/master/docs/optimization.gif)

### Using the autolock

In order to use the autolock, enter some PID parameters first. Note that the sign of the parameters is determined automatically. After clicking the green button, you can select the line you want to lock to by clicking and dragging over it. The autolock will then center this line, decrease the scan range and try to lock to the middle between minimum and maximum contained in your selection.

![image](https://raw.githubusercontent.com/hermitdemschoenenleben/linien/master/docs/screencast.gif)

The following options are available:
 * **Determine signal offset**: If this checkbox is ticked, the autolock will adapt the y-offset of the signal such that the middle between minimum and maximum is at the zero crossing. This is especially useful if you have a large background signal (e.g. the Doppler background in FMS spectroscopy).
 * **Check lock**: Directly after turning on the lock, the control signal is investigated. If it shifts too much, the lock is assumed to have failed.
 * **Watch lock**: This option tells the Linien to continuously watch the control signal when the laser is locked. If steep changes are detected, a relock is initiated.

If you experience trouble with the autolock, this is most likely due to a bad signal to noise ratio or strong laser jitter.

### Using the manual lock

If you have problems with the autolock, you may also lock manually. Activate the *Manual* tab and use the controls in the top (*Zoom* and *Position*) to center the line you want to lock to. Choose whether the target slope is rising or falling and click the green button.

Transfer function
-----------------

Transfer function of the PID is given by
```
L(f) = kp + ki / f + kd * f
```
with `kp=P/4096`, `ki=I/0.1s` and `kd=D / (2**6 * 125e6)`.
Note that this equation does not account for filtering before the PID (cf. *Modulation, Ramp & Spectroscopy* tab).

![image](https://raw.githubusercontent.com/hermitdemschoenenleben/linien/master/docs/transfer.png)

Scripting interface
-------------------

In addition to the GUI, Linien can also be controlled using python. For that purpose, installation via pip is required (see above).

Then, you should start the Linien server on your RedPitaya. This can be done by running the GUI client and connecting to the device (see above). Alternatively, `LinienClient` has the option `autostart_server`.

Once the server is up and running, you can connect using python:
```python
from linien.client.connection import LinienClient, MHz, Vpp
c = LinienClient(
    {'host': 'rp-XXXXXX.local', 'username': 'root', 'password': 'root'}, autostart_server=True,
    restore_parameters=False
)

# read out the modulation frequency
print(c.parameters.modulation_frequency.value / MHz)

# have a look at https://github.com/hermitdemschoenenleben/linien/blob/master/linien/server/parameters.py
# for a documentation of all parameters that can be accessed and modified

# set modulation amplitude
c.parameters.modulation_amplitude.value = 1 * Vpp
# in the line above, we set a parameter. This is not written directly to the
# FPGA, though. In order to do this, we have to call write_data():
c.connection.root.write_data()

# additionally set ANALOG_OUT_1 to 1.2 volts DC (you can use this to control other devices of your experiment)
c.parameters.analog_out_1.value = 1.2 * ANALOG_OUT_V

# GPIO outputs can also be set
c.parameters.gpio_p_out.value = 0b11110000 # 4 on, 4 off
c.parameters.gpio_n_out.value = 0b01010101 # 4 on, 4 off

# again, we have to call write_data in order to write the data to the FPGA
c.connection.root.write_data()

# it is also possible to set up a callback function that is called whenever a
# parameter changes (remember to call `call_listeners()` periodically)
def on_change(value):
    # this function is called whenever `my_param` changes on the server.
    # note that this only works if `call_listeners` is called from
    # time to time as this function is responsible for checking for
    # changed parameters.
    print('parameter arrived!', value)

c.parameters.modulation_amplitude.on_change(on_change)

from time import sleep
for i in range(10):
    c.parameters.call_listeners()
    if i == 2:
        c.parameters.modulation_amplitude.value = 0.1 * Vpp
    sleep(.1)

# plot control and error signal
import pickle
from matplotlib import pyplot as plt
plot_data = pickle.loads(c.parameters.to_plot.value)

# depending on the status (locked / unlocked), different signals are available
print(plot_data.keys())

# if unlocked, signal1 and signal2 contain the error signal of channel 1 and 2
# if the laser is locked, they contain error signal and control signal.
if c.parameters.lock.value:
    plt.title('laser is locked!')
    plt.plot(plot_data['control_signal'], label='control signal')
    plt.plot(plot_data['error_signal'], label='error signal')
else:
    plt.title('laser is ramping!')
    plt.plot(plot_data['error_signal_1'], label='error signal channel 1')
    plt.plot(plot_data['error_signal_2'], label='error signal channel 2')

plt.legend()
plt.show()
```

For a full list of parameters that can be controlled or accessed have a
look at
[parameters.py](https://github.com/hermitdemschoenenleben/linien/blob/master/linien/server/parameters.py). Remember that changed parameters are not written to the FPGA unless `c.connection.root.write_data()` is called.

Updating Linien
---------------

Before installing a new version of linien, open the previously installed client and click the "Shutdown server" button. Don't worry, your settings and parameters will be saved. Then you may install the latest client on your local PC as described in the [getting started](#getting-started) section above. The next time you connect to RedPitaya, Linien will install the matching server version.


Development
-----------

```bash
git clone https://github.com/hermitdemschoenenleben/linien.git
```

Then, create a file named `checked_out_repo/linien/VERSION` which contains

```
dev
```
(no newlines).

This ensures that local changes of the server's code are automatically uploaded to RedPitaya when you launch the client. Please note that this only h

### Architecture

Linien contains three components:
* The client: Connects to the server, runs the GUI, etc.
* The server: Handles connections from the client, runs long-running tasks like the autolock or the optimization algorithm. Connects to the acquisition process for communication with the FPGA.
* The acquisition process: Handles the low-level communication with the FPGA (reading / writing registers)

The communication between the components takes place using [rpyc](https://rpyc.readthedocs.io/en/latest/).

For development purposes, you can run the first two components on your local machine to simplify debugging. Only the acquisition process has to run on the RedPitaya. In a production version of linien, server and acquisition process run on RedPitaya.

### Running the code

Before running the development version check that no production version of the server is running on the RedPitaya by executing `linien_stop_server` on the RedPitaya. Now you need to have an FPGA bitstream at `linien/server/linien.bin`. You have two choices:
* [Build the gateware](#building-the-fpga-image): this makes sense if you want to change the FPGA programming.
* Use the gateware of the latest release: if you just want to work on the python client or server code without touching the FPGA gateware, this approach is right for you as it is way easier:
    * Install linien-server using pip: `pip3 install linien-server`
    * Find out where it was installed to: `python3 -c "import linien; print(linien.__path__)"`
    * In that folder go to linien/server and copy this file to your development server folder.

Now you can launch the client

```
python3 linien/client/client.py
```

and you can connect to your RedPitaya.
If you have set `checked_out_repo/linien/VERSION` to dev ([see above](#development)), this automatically uploads your local code to the RedPitaya and starts the server.
The FPGA bitstream will also be transferred to the RedPitaya and loaded on the FPGA.

### Run server locally

For debugging it may be helpful to execute the server component on
your machine (e.g. if you want to work on the autolock and want to plot the spectra). In order to make this work, you have to start `/linien/server/acquisition_process.py` on your RedPitaya using SSH. This process provides remote access to the FPGA registers. Then, you can run the server locally and connect to the FPGA registers:

```
python3 server/server.py --remote-rp=root:password@rp-f0xxxx.local
```

Now, you can start the client. **Important**: Be sure not to connect your client to the RedPitaya, but to "localhost" instead.

### Fake server

If you just want to test the GUI, there is also a fake server that you can run locally on your machine:

```bash
python3 server/server.py --fake
```

This fake server just outputs random data. Then you can connect to \"localhost\" using the client.

### Building the FPGA image

For building the FPGA image, you need to install Xilinx Vivado first. Then, call `scripts/build_gateware.sh`. In the end, the bitstream is located at `linien/server/linien.bin`. **Note**: So far, this was tested only with Linux. It should work on Windows 10, though, when calling the script inside Windows Powershell.

### Releasing a new version

First, update the version number in the `checked_out_repo/linien/VERSION` file. Then you can build and upload the package to pypi using `scripts/upload_pypi.sh`. Finally, build the standalone client using `build_standalone_client.sh` (you have
to do this on the platform you want to build the standalone client for). When on Windows 10, both scripts have to be started in Windows Powershell.
Upload the standalone to a github release. Release the new version to flathub.

Troubleshooting
---------------

### Connection problems

If the client fails to connect to a RedPitaya, first check whether you
can ping it by executing

```bash
ping rp-f0xxxx.local
```

in a command line. If this works, check whether you can connect via SSH.
On Windows, you have to [install a SSH client](https://www.putty.org),
on linux you can execute

```bash
ssh rp-f0xxxx.local
```

on the command line.

FAQs
----

### Can I run linien and the RedPitaya web application / scpi interface at the same time

No, this is not possible as linien relies on a customized FPGA bitstream.

### What control bandwidth is achievable with linien?

The propagation delay is roughly 300 ns, thus approximately 3 MHz bandwidth are possible.

Troubleshooting
----

### Updating or installing fails

- make sure that your RedPitaya is connected to the internet
- if the orange LED stops blinking and RedPitaya becomes unresponsive, your SD card is probably faulty

Citation
----
```
@misc{linien,
  author = {Benjamin Wiegand},
  title = {Linien,
  year = {2020},
  publisher = {GitHub},
  journal = {GitHub repository},
  howpublished = {\url{https://github.com/hermitdemschoenenleben/linien}}
}
```


See Also
--------

-   [RedPID](https://github.com/quartiq/redpid): the basis of linien
