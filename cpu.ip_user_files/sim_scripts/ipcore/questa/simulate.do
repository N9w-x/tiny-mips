onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib ipcore_opt

do {wave.do}

view wave
view structure
view signals

do {ipcore.udo}

run -all

quit -force
