#ifndef CKEY_H
#define CKEY_H

#ifdef __cplusplus
extern "C" {
#endif

void *ckey_init(int rate, int channels);
void ckey_clear(void *c);

void ckey_add_audio(void *c, const float *buf, size_t len);
int ckey_analyse(void *c);

#ifdef __cplusplus
}
#endif

#endif
