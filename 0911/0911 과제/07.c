#include <stdio.h>
#include <string.h>

int Hval2(char c){
    if(c>='0'&&c<='9') return c-'0';
    if(c>='A'&&c<='F') return 10+(c-'A');
    if(c>='a'&&c<='f') return 10+(c-'a');
    return -1;
}
char Hd2(int v){ return (v<10)?('0'+v):('A'+(v-10)); }

void mul_hex_digit(const char *hex, char single, char out[1105]){
    int d=Hval2(single);
    int i=(int)strlen(hex)-1, carry=0, k=0;
    char buf[1105];
    while(i>=0 || carry){
        int a=(i>=0)?Hval2(hex[i]):0; if(i>=0) i--;
        int p=a*d+carry;
        buf[k++]=Hd2(p&0xF);
        carry=p>>4;
    }
    for(int j=0;j<k;j++) out[j]=buf[k-1-j];
    out[k]='\0';
}

int main(void){
    char out[1105];
    mul_hex_digit("ABCDEF",'7',out); printf("7*ABCDEF = %s\n",out);
    return 0;
}