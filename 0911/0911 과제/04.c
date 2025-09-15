#include <stdio.h>

char hex_digit(int v) { return (v < 10) ? ('0' + v) : ('A' + (v - 10)); }

void int_to_hex(int x, char out[64]) {
    if (x == 0) { out[0] = '0'; out[1] = '\0'; return; }
    unsigned int u = (x < 0) ? (unsigned int)(-(long long)x) : (unsigned int)x;
    char buf[64]; int k = 0;
    while (u > 0) { buf[k++] = hex_digit((int)(u & 0xF)); u >>= 4; }
    if (x < 0) buf[k++] = '-';
    buf[k] = '\0';
    for (int i = 0; i < k/2; i++) { char t = buf[i]; buf[i] = buf[k-1-i]; buf[k-1-i] = t; }
    for (int i = 0; buf[i]; i++) out[i] = buf[i];
    out[k] = '\0';
}

int main(void) {
    char s[64];
    int_to_hex(255, s);   printf("255 -> %s\n", s);
    int_to_hex(-4095, s); printf("-4095 -> %s\n", s);
    return 0;
}