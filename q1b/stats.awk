BEGIN{
	totalSent=0;
	totalReceived=0;
	totalLost=0;
}
{
	packetType=$5
	event=$1
	if(packetType=="cbr")
	{
		if(event=="+")
		{
			totalSent++;
		}
		else if(event=="r")
		{
			totalReceived++;
		}
		else if(event =="d")
		{
			totalLost++;
		}
	}
}END{
	printf("Total received = %d\n",totalReceived);
	printf("Total Dropped = %d\n",totalLost);
	printf("Total Sent = %d\n",totalSent);
}							
