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

<img width="1850" height="1113" alt="Screenshot 2026-10-19 151945" src="https://github.com/user-attachments/assets/7f05264a-9a53-4162-953b-d65ccccda016" />

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
