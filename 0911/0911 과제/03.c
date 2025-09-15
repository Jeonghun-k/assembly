#include <stdio.h>

void int_to_binary(int x, char out[64]) {
    if (x == 0) { out[0] = '0'; out[1] = '\0'; return; }
    unsigned int u = (x < 0) ? (unsigned int)(-(long long)x) : (unsigned int)x;
    char buf[64]; int k = 0;
    while (u > 0) { buf[k++] = (u & 1u) ? '1' : '0'; u >>= 1; }
    if (x < 0) buf[k++] = '-';
    buf[k] = '\0';
    // 뒤집기
    for (int i = 0; i < k/2; i++) { char t = buf[i]; buf[i] = buf[k-1-i]; buf[k-1-i] = t; }
    for (int i = 0; buf[i]; i++) out[i] = buf[i];
    out[k] = '\0';
}

int main(void) {
    char s[64];
    int_to_binary(13, s);  printf("13 -> %s\n", s);
    int_to_binary(-42, s); printf("-42 -> %s\n", s);
    return 0;
}