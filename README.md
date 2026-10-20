# sky130-inverter-layout
This project presents the design of a CMOS inverter implemented with the SkyWater SKY130A open-source PDK and open-source EDA tools.
The schematic is captured in xschem and verified through ngspice transient simulation, while the physical layout is created in Magic.
Layout correctness is confirmed with netgen LVS, where the extracted layout matches the schematic.
The design uses a PMOS of 3 um and an NMOS of 4.5 um total width, with a channel length of 0.18 um and 3 fingers each.
## Step 1 - Tool Installation

The following open-source tools were installed on Ubuntu (WSL) to work with the SkyWater SKY130A PDK:

| Tool | Purpose |
|------|---------|
| xschem | Schematic capture |
| ngspice (45.2) | Circuit simulation |
| Magic | Layout, DRC and extraction |
| netgen (1.5.324) | Layout vs Schematic (LVS) |
| open_pdks (SKY130A) | PDK installation and tool setup files |

### Installation

Install the build dependencies:

```bash
sudo apt update
sudo apt install -y build-essential git tcl-dev tk-dev libx11-dev libxpm-dev libcairo2-dev flex bison
```

Build xschem, Magic and netgen from source, and install ngspice:

```bash
git clone <tool-repository-url>
cd <tool-folder>
./configure
make
sudo make install
```

Install the SKY130A PDK last, so it can link the xschem and Magic setup files:

```bash
git clone https://github.com/RTimothyEdwards/open_pdks.git
cd open_pdks
./configure --enable-sky130-pdk
make
sudo make install
```

### Verification

Each tool opens from the terminal without errors:

```bash
magic
xschem
netgen
ngspice
```

![Magic launch](images/01_magic_launch.png)

![xschem with SKY130 symbols](images/02_xschem_sky130_symbols.png)

![magic, xschem and netgen](images/03_tools_terminal.png)

![ngspice](images/04_ngspice_terminal.png)
