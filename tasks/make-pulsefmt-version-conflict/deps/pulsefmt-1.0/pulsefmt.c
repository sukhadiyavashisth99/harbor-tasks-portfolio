#include "pulsefmt.h"

const char *pf_version(void) {
    return "1.0";
}

const char *pf_render_total(uint64_t total_bytes) {
    (void) total_bytes;
    return "legacy-format";
}
