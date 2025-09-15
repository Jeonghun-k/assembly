#include <stdio.h>
#include <stdint.h>

uint16_t parse_bin16(const char *s) {
    uint16_t v = 0;
    for (int i = 0; s[i]; i++) {
        if (s[i] == '0' || s[i] == '1') {
            v = (uint16_t)((v << 1) | (s[i] - '0'));
        }
    }
    return v;
}

int main(void) {
    printf("%u\n", parse_bin16("00010110"));   // 22
    printf("%u\n", parse_bin16("1111111111111111")); // 65535
    return 0;
}