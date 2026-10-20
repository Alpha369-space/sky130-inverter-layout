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
![xschem with SKY130 symbols](images/02_xschem_sky130_symbols.png)

![magic, xschem and netgen](images/03_tools_terminal.png)

![ngspice](images/04_ngspice_terminal.png)
