#include <stdio.h>
#include <string.h>

int Hval(char c){
    if(c>='0'&&c<='9') return c-'0';
    if(c>='A'&&c<='F') return 10+(c-'A');
    if(c>='a'&&c<='f') return 10+(c-'a');
    return -1;
}
char Hd(int v){ return (v<10)?('0'+v):('A'+(v-10)); }

void add_hex(const char *a, const char *b, char out[1105]) {
    int ia=(int)strlen(a)-1, ib=(int)strlen(b)-1, carry=0, k=0;
    char buf[1105];
    while(ia>=0 || ib>=0 || carry){
        int da=0, db=0;
        if(ia>=0) da=Hval(a[ia--]);
        if(ib>=0) db=Hval(b[ib--]);
        int s=da+db+carry;
        buf[k++]=Hd(s&0xF);
        carry=s>>4;
    }
    for(int i=0;i<k;i++) out[i]=buf[k-1-i];
    out[k]='\0';
}

int main(void){
    char out[1105];
    add_hex("FFFF","1",out); printf("FFFF+1 = %s\n",out);
    return 0;
}