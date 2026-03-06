#ifndef PULSEFMT_H
#define PULSEFMT_H

#include <stdint.h>
#include <stddef.h>

typedef struct {
    const char *label;
    uint32_t shard_count;
} pf_context;

void pf_context_init(pf_context *ctx, const char *label, uint32_t shard_count);
void pf_render_total(const pf_context *ctx, uint64_t total_bytes, char *out, size_t out_size);
const char *pf_version(void);

#endif
