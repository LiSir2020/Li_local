onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib SuperMusic_opt

do {wave.do}

view wave
view structure
view signals

do {SuperMusic.udo}

run -all

quit -force
