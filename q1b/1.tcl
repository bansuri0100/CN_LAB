#Simulate a three nodes point to point network with duplex links between them.
#Set the queue size and vary bandwidth and find the number of packets dropeped.

#Create a siumulator object
set ns [new Simulator]

$ns color 2 red

#Tell the simulator to use static routing 

$ns rtproto Static

#Set up trace files.

set traceFile [ open 1.tr w]
$ns trace-all $traceFile

#Set nam files.

set namFile [open 1.nam w]
$ns namtrace-all $namFile

proc finish{}	{
	global ns namFile traceFile
	
	$ns flush-trace
	#Close trace files.
	close $traceFile
	close $namFile
	exec awk -f stats.awk 1.tr &
	exec nam out1.nam &
	exit 0
}

#Set up 3 nodes
set n(1) [$ns node]
set n(2) [$ns node]
set n(3) [$ns node]

#Set duplex links.
$ns duplex-link $n(1) $n(2) 0.5Mb 20ms DropTail
$ns duplex-link $n(2) $n(3) 0.5Mb 20ms DropTail
$ns queue-limit $n(1) $n(2) 10
$ns queue-limit $n(2) $n(3) 10

#aesthetics

#source(UDP)

$n(1) shape hexagon
$n(1) color red

#destination(UDP)

$n(3) shape square
$n(3) color blue

#Create UDP agent and attach it to node 1
set udp0 [new agent/UDP]
$ns attach-agent $n(1) $udp0

#Create CBR traffic source and attach it to UDP0

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 512
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

#Create a new null agent (traffic sink )and attach it to node 3
set null0 [new Agent/Null]
$ns attach-agent $n(3) $null0

#Connect UDP source with Sink destination and assign flow id color
$ns connect $udp0 $null0
$udp0 set fid_2

#Sim events

$ns at 0.5 "$cbr0 start"
$ns at 2.0 "$cbr0 stop"
$ns at 2.0 "finish"

#Run simulation

$ns run










 



	
