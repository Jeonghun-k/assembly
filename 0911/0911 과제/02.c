#include<stdio.h>
#include<stdint.h>

int hax(char c) {
    if ('0' <= c && c <= '9') return c - '0';
    if ('a' <= c && c <= 'f') return c - 'a' + 10;
    if ('A' <= c && c <= 'F') return c - 'A' + 10;
    return -1;
}

uint32_t hex32(const char *s){
    uint32_t v = 0; int i = 0;
    if(s[0] == '0' && (s[1] == 'x' || s[1] == 'X')) i = 2;
    for(; s[i]; i++){
        int h = hax(s[i]);
        if(h < 0) break;
        v = (v << 4) | (uint32_t)h;        
}
return v;
}

int main(void){
    printf("%u\n", hex32("0x1A3F")); // 6719
    printf("%u\n", hex32("FFEE"));   // 65518
    return 0;
}