# sky130-inverter-layout
This project presents the design of a CMOS inverter implemented with the SkyWater SKY130A open-source PDK and open-source EDA tools.
The schematic is captured in xschem and verified through ngspice transient simulation, while the physical layout is created in Magic.
Layout correctness is confirmed with netgen LVS, where the extracted layout matches the schematic.
The design uses a PMOS of 3 um and an NMOS of 4.5 um total width, with a channel length of 0.18 um and 3 fingers each.
## Step 1 - Tool Installation

The following open-source tools are installed on Ubuntu (WSL):

| Tool | Purpose |
|------|---------|
| Magic | Layout, DRC and extraction |
| ngspice | Circuit simulation |
| xschem | Schematic capture |
| netgen | Layout vs Schematic (LVS) |

### 1.1 Install dependencies

```bash
sudo apt update
sudo apt install -y build-essential git autoconf automake libtool \
  tcl-dev tk-dev libx11-dev libxpm-dev libxrender-dev libcairo2-dev \
  libgl1-mesa-dev libglu1-mesa-dev libxaw7-dev libreadline-dev \
  libsuitesparse-dev flex bison
```

### 1.2 Magic

```bash
cd ~
git clone https://github.com/RTimothyEdwards/magic.git
cd magic
./configure
make
sudo make install
```

### 1.3 ngspice

```bash
cd ~
git clone https://git.code.sf.net/p/ngspice/ngspice ngspice
cd ngspice
./autogen.sh
./configure --with-x --with-readline=yes --enable-xspice --enable-cider --enable-klu
make
sudo make install
```

### 1.4 xschem

```bash
cd ~
git clone https://github.com/StefanSchippers/xschem.git
cd xschem
./configure
make
sudo make install
```

### 1.5 netgen

```bash
cd ~
git clone https://github.com/RTimothyEdwards/netgen.git
cd netgen
./configure
make
sudo make install
```
## Step 2 - Checking Tool Installation and Creating Directories

### 2.1 Check that each tool is installed

Run each command in the Ubuntu terminal. Every tool should open without errors.

**Magic**

```bash
magic
```

Magic opens the layout window. It shows `Technology: minimum` at this point because the SKY130A PDK is not loaded yet.

<img width="1548" height="1080" alt="image" src="https://github.com/user-attachments/assets/1ce171f5-995c-4d57-b50b-6ceb4456e5c3" />

**xschem**

```bash
xschem
```

xschem opens its schematic editor (shown here with the `sky130_tests/top.sch` test schematic). Type `quit` in the xschem console to close it.

<img width="1917" height="1113" alt="Screenshot 2026-10-19 152729" src="https://github.com/user-attachments/assets/de36949f-73b4-40af-be45-3eb52be52f7f" />


**netgen**

```bash
netgen
```

netgen opens its console and prints the version (1.5.324). The `format` and `global` warnings are harmless.

<img width="1696" height="962" alt="Screenshot 2026-10-19 153636" src="https://github.com/user-attachments/assets/34d981f2-3206-4b5f-9f1d-14b8b7c844ee" />


**ngspice**

```bash
ngspice
```

ngspice starts and shows version 45.2 with the `ngspice 2 ->` prompt. Type `quit` to exit.

<img width="1147" height="710" alt="Screenshot 2026-10-19 153657" src="https://github.com/user-attachments/assets/f5aed6ab-2b37-4835-8a17-dab8638788f0" />


### 2.2 Create the project directories

Create the project folder with one subfolder for each tool, and link the SKY130A setup files into each one:

```bash
cd
mkdir inverter
cd inverter
mkdir xschem
mkdir mag
mkdir netgen
cd xschem
ln -s /usr/local/share/pdk/sky130A/libs.tech/xschem/xschemrc
ln -s /usr/local/share/pdk/sky130A/libs.tech/ngspice/spinit .spiceinit
cd ../mag
ln -s /usr/local/share/pdk/sky130A/libs.tech/magic/sky130A.magicrc .magicrc
cd ../netgen
ln -s /usr/local/share/pdk/sky130A/libs.tech/netgen/sky130A_setup.tcl setup.tcl
cd ..
```

| Folder | Linked file | Purpose |
|--------|-------------|---------|
| `xschem/` | `xschemrc` | Loads the SKY130 symbols in xschem |
| `xschem/` | `.spiceinit` | ngspice settings for SKY130 |
| `mag/` | `.magicrc` | Loads the sky130A technology in Magic |
| `netgen/` | `setup.tcl` | LVS setup file for SKY130A |

## step 2 - Creating inverter schematic using xschem
An initial schematic is made by placing a PMOS and an NMOS from the open_pdk library
The gates, drains, sources and pins are wired together and named to form the inverter
<img width="1071" height="540" alt="Screenshot 2026-10-18 162134" src="https://github.com/user-attachments/assets/b770f0b7-d0ba-452e-90a4-1fea9cf5a52c" />

The inverter symbol is placed in a new schematic and connected to a supply source and an input source
The model library and the transient analysis commands are added to run the simulation

<img width="1077" height="440" alt="Screenshot 2026-10-18 162203" src="https://github.com/user-attachments/assets/22d28979-0094-428a-9258-9cec582259df" />

The circuit is netlisted and simulated from xschem, and ngspice plots the input and output waveforms
The output goes low when the input goes high, which confirms that the circuit works as an inverter

<img width="1888" height="1137" alt="Screenshot 2026-10-18 165439" src="https://github.com/user-attachments/assets/2eeeff08-87e5-4a85-8faa-38ef05bc430e" />

## step 4 - Creating inverter layout in Magic and exporting its netlist
Importing the netlist into Magic. The xschem netlist is imported into Magic, which places the transistors and creates the pins this are arranged in magic

<img width="1886" height="1096" alt="image" src="https://github.com/user-attachments/assets/c0600c4f-bc07-431a-aae7-6deafffbdca5" />

The params window of each transistor shows its settings, and applying them redraws the device.The NMOS and PMOS are then arranged with the input and output pins on either side.

<img width="1430" height="1127" alt="image" src="https://github.com/user-attachments/assets/4c9af30c-cc11-45ca-bfc5-4987271ac547" />

<img width="1342" height="1090" alt="image" src="https://github.com/user-attachments/assets/5e68bc62-13c2-4854-a04d-db194f88bc96" />

The gates, drains and supplies are joined with metal, and each pin sits on its own metal pad. This gives the finished inverter layout.

<img width="1292" height="1086" alt="image" src="https://github.com/user-attachments/assets/a1e83ea9-4e40-4d3f-9156-45a094eb2a7f" />

### Extract the layout using Magic
After completing the layout, you need to extract the electrical connectivity from the physical design.
Open your inverter layout in Magic and use the extraction commands.

```bash
extract all
ext2spice lvs
ext2spice
```

## step 4 - Run Netgen for LVS verification

This commands runs Netgen LVS (Layout Versus Schematic) to compare the schematic SPICE netlist with the netlist extracted from the Magic layout using SKY130A technology rules.
It generates lvs_report.txt, which indicates whether the circuits match or identifies differences in their devices and connections

```bash
netgen -batch lvs \
"/path/to/schematic.spice inverter" \
"/path/to/extracted.spice inverter" \
/usr/local/share/pdk/sky130A/libs.tech/netgen/sky130A_setup.tcl \
lvs_report.txt
```

<img width="1145" height="1136" alt="Screenshot 2026-10-19 000525" src="https://github.com/user-attachments/assets/d5230aa1-35c9-4894-b2c6-ba3087ab0c7c" />














