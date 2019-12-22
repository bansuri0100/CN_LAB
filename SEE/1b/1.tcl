set ns [new Simulator]
set traceFile [open 1.tr w]
$ns trace-all $traceFile
set namFile [open 1.nam w]
$ns namtrace-all $namFile

proc finish {} {
	global ns namFile traceFile
	$ns flush-trace 
	close $namFile
	close $traceFile
	
	exec awk -f 1.awk 1.tr &
	exec nam 1.nam &
	exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

$ns duplex-link $n0 $n1 1Mb 20ms DropTail
$ns duplex-link $n1 $n2 0.1Mb 20ms DropTail
$ns queue-limit $n1 $n2 10

set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 400
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

set sink0 [new Agent/Null]
$ns attach-agent $n2 $sink0
$ns connect $udp0 $sink0

$ns at 0.5 "$cbr0 start"
$ns at 4.5 "$cbr0 stop"
$ns at 5.0 "finish"

$ns run








	
	