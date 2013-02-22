#include <stdio.h>

#include "ckey.h"

#define RATE 44100

#define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))

int main(int argc, char *argv[])
{
	void *ckey;
	int key;

	ckey = ckey_init(RATE, 1);

	for (;;) {
		float buf[4096];
		ssize_t z;

		z = fread(buf, sizeof *buf, ARRAY_SIZE(buf), stdin);
		if (z == -1)
			break;

		ckey_add_audio(ckey, buf, z);

		if (z < ARRAY_SIZE(buf))
			break;
	}

	key = ckey_analyse(ckey);

	printf("%d\n", key);

	return 0;
}
