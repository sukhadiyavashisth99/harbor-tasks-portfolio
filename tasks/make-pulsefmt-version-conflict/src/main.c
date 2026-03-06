#include <stdio.h>
#include <stdint.h>
#include "pulsefmt.h"

int main(void) {
    pf_context ctx;
    char rendered[64];

    pf_context_init(&ctx, "cache-audit", 7);
    pf_render_total(&ctx, 1048576ULL, rendered, sizeof(rendered));

    printf("CACHE_AUDIT_OK\n");
    printf("pulsefmt=%s\n", pf_version());
    printf("rendered=%s\n", rendered);

    return 0;
}

