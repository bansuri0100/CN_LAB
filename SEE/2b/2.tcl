set ns [new Simulator]
set namFile [open 1.nam w]
$ns namtrace-all $namFile
set traceFile [open 1.tr w]
$ns trace-all $traceFile

proc finish {} {
	global ns namFile traceFile
	$ns flush-trace
	close $traceFile
	close $namFile
	
	exec awk -f 1.awk 1.tr &
	exec nam 1.nam &
	exit 0
}
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]	

$ns duplex-link $n0 $n1 1Mbms 10ms DropTail
$ns duplex-link $n1 $n2 1Mbps 10ms DropTail
$ns duplex-link $n2 $n3 1Mbps 10ms DropTail
$ns queue-limit $n0 $n1 10


	
