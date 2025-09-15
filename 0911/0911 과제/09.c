#include <stdio.h>
#include <string.h>

void sub_bin(const char *A,const char *B,char out[1105]){
    int i=(int)strlen(A)-1, j=(int)strlen(B)-1, borrow=0, k=0;
    char buf[1105];
    while(i>=0 || j>=0){
        int a=(i>=0)?A[i]-'0':0;
        int b=(j>=0)?B[j]-'0':0;
        int t=a-borrow-b;
        if(t<0){ t+=2; borrow=1; } else borrow=0;
        buf[k++]=(char)('0'+t);
        i--; j--;
    }
    while(k>1 && buf[k-1]=='0') k--; // 앞쪽 0 제거
    for(int x=0;x<k;x++) out[x]=buf[k-1-x];
    out[k]='\0';
}

int main(void){
    char out[1105];
    sub_bin("10001000","00000101",out); printf("10001000-00000101 = %s\n",out);
    return 0;
}