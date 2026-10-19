v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -130 -20 -70 -20 {lab=in}
N -70 -50 -70 -20 {lab=in}
N -70 -20 -70 40 {lab=in}
N -30 -150 -30 -80 {lab=vdd}
N -30 -150 -10 -150 {lab=vdd}
N -30 -20 -30 10 {lab=out}
N -30 70 -30 120 {lab=vss}
N -30 120 -10 120 {lab=vss}
N -30 40 -10 40 {lab=vss}
N -10 40 -10 120 {lab=vss}
N -30 -10 140 -20 {lab=out}
C {sky130_fd_pr/nfet_01v8.sym} -50 40 0 0 {name=M1
W=4.5
L=0.18
nf=3 
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8.sym} -50 -50 0 0 {name=M2
W=3
L=0.18
body=VDD
nf=3
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {iopin.sym} -10 -150 0 0 {name=p1 lab=vdd}
C {ipin.sym} -130 -20 0 0 {name=p2 lab=in
}
C {ipin.sym} 140 -20 0 0 {name=p3 lab=out}
C {iopin.sym} -10 120 0 0 {name=p4 lab=vss}
