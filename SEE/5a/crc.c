#include<stdio.h>
#include<string.h>

#define N strlen(gen)
 
char test[28];//stores test data
char chs[28]; //stores crc checksum
char gen[]="1101"; //generator polynomial
int a,j,i,e;
 
void xor()
{
    for(i = 1;i < N; i++)   // do xor operation from index 1 till N-1
    chs[i] = (( chs[i] == gen[i])?'0':'1'); 
}

 
void crc()
{
    for(j=0;j<N;j++)
        chs[j]=test[j];   //copy the padded data to chs array
    do{
        if(chs[0]=='1')  // if the first element is 1 , only then go ahead with xor operation
            xor(); //xor with generator polynomial 
        for(i=0;i<N-1;i++)
            chs[i]=chs[i+1]; // as we are not doing xor operation for the 0th index , we just push it out from the existing cs array and make the 1st index as the 0th index.
        chs[i]=test[j++]; // as we pushed the element at the 0th index out , we take the next element from the padded data to our xor operand.
    }while(j<=a+N-1); // we continue this process till all the extra elements from the padded data are added to our xor operand and the division process is complete.
}
 
int main()
{
    printf("\nEnter data : ");
    scanf("%s",test);
 
    printf("\n Generator polynomial : %s",gen);
    a=strlen(test);
    
    for(j=a;j<a+N-1;j++)
        test[j]='0';
        
    printf("\nPadded data is : %s",test);
    
    crc();
    printf("\nChecksum is : %s",chs);
    
    for(j=a;j<a+N-1;j++)
        test[j]=chs[j-a];
    
    printf("\nFinal codeword is : %s",test);
   
    printf("\nTest error detection 0(yes) 1(no)? : ");
    scanf("%d",&e);
    
    if(e==0)
    {
        e = 6;
        printf("\n Error is inserted at position 6.");
        
        test[e-1]=( test[e-1]=='0')?'1':'0';
        
        printf("\nErroneous data : %s\n",test);
    }
    
    crc();
    for(j=0;(j<N-1) && (chs[j]!='1');j++){}  // checksum (i.e cs array ) should have all zeroes after performing crc operation, so if any 1 is found e is not incremented and hence e will become less than N-1 and therefore we can say there is an error in the transmitted message.
        
        if(j<N-1)
            printf("\nError detected\n\n");
        else
            printf("\nNo error detected\n\n");
            
        return 0;
}
