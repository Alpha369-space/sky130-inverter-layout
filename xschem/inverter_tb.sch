v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -190 -0 -140 0 {lab=in}
N -240 -40 -240 -0 {lab=#net1}
N -240 -40 160 -40 {lab=#net1}
N 160 -40 160 -20 {lab=#net1}
N 160 -0 160 60 {lab=gnd}
N -40 60 160 60 {lab=gnd}
N -190 60 -40 60 {lab=gnd}
N -240 60 -190 60 {lab=gnd}
N -140 -60 -140 -20 {lab=out}
N -140 -60 -110 -60 {lab=out}
N -180 -90 -180 -0 {lab=in}
C {inverter.sym} 10 -10 0 0 {name=x1}
C {gnd.sym} -40 60 0 0 {name=l1 lab=gnd}
C {opin.sym} -110 -60 0 0 {name=p1 lab=out}
C {vsource.sym} -190 30 0 0 {name=V1 value=PWL"(0 0 20N 0 900N 1.8)" savecurrent=false}
C {vsource.sym} -240 30 0 0 {name=V2 value=1.8 savecurrent=false}
C {opin.sym} -180 -90 0 0 {name=p2 lab=in}
C {code_shown.sym} 70 -70 0 0 {name=s1 only_toplevel=false value=".lib /usr/local/share/pdk/sky130A/libs.tech/combined/sky130.lib.spice tt"}
C {code_shown.sym} 80 100 0 0 {name=s2 only_toplevel=false value=".control
tran 1n 1u
write inverter_tb.raw
plot v(in) v(out)
.endc"}
