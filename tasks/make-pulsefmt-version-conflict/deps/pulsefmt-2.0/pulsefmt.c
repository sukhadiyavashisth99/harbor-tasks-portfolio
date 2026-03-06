#include <stdio.h>
#include "pulsefmt.h"

void pf_context_init(pf_context *ctx, const char *label, uint32_t shard_count) {
    ctx->label = label;
    ctx->shard_count = shard_count;
}

void pf_render_total(const pf_context *ctx, uint64_t total_bytes, char *out, size_t out_size) {
    snprintf(out, out_size, "%s:%u:%llu",
             ctx->label,
             ctx->shard_count,
             (unsigned long long) total_bytes);
}

const char *pf_version(void) {
    return "2.0";
}
