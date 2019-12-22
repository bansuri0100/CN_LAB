BEGIN {
	dcount=0;
	rcount=0;
}
{
	event=$1;
	if(event=="d")
		dcount++;
	if(event=="r")
		rcount++;
}
END{
	printf("No of packets dropped = %d\n",dcount);
	printf("No of packets received = %d\n",rcount);
}					
