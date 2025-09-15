#include <stdio.h>
#include <string.h>

void add_base_b(const char *a, const char *b, int base, char out[1105]) {
    int ia = (int)strlen(a) - 1;
    int ib = (int)strlen(b) - 1;
    int carry = 0, k = 0;
    char buf[1105];

    while (ia >= 0 || ib >= 0 || carry) {
        int da = 0, db = 0;
        if (ia >= 0) da = a[ia--] - '0';
        if (ib >= 0) db = b[ib--] - '0';
        int s = da + db + carry;
        buf[k++] = (char)('0' + (s % base));
        carry = s / base;
    }
    // 뒤집기
    for (int i = 0; i < k; i++) out[i] = buf[k-1-i];
    out[k] = '\0';
}

int main(void) {
    char out[1105];
    add_base_b("999", "1", 10, out); printf("999+1 (10진) = %s\n", out);
    add_base_b("1111", "1", 2, out); printf("1111+1 (2진) = %s\n", out);
    return 0;
}