/*
 * Simple C wrapper to libKeyFinder
 *
 * Writing option parsing and file I/O tends to come out "C style"
 * anyway and the result is usually a mix of C++ and C
 * concepts. Instead, wrap the C++ library to present a simple C
 * interface as a bridge -- all the nasty stuff is in this file.
 */

#include <stdlib.h>

#include "ckey.h"
#include "keyfinder.h"

/*
 * Initialise key detection contect
 *
 * Return: handle to context
 */

void* ckey_init(int rate, int channels)
{
	KeyFinder::AudioData *a = new KeyFinder::AudioData();

	a->setFrameRate(rate);
	a->setChannels(channels);

	return static_cast<void*>(a);
}

/*
 * Finish up with key detection context
 */

void ckey_clear(void *c)
{
	KeyFinder::AudioData *a = static_cast<KeyFinder::AudioData*>(c);
	delete a;
}

/*
 * Register some audio for key detection. The len is the number of
 * frames ie. there is one float for each channel.
 */

void ckey_add_audio(void *c, const float *buf, size_t len)
{
	KeyFinder::AudioData *a = static_cast<KeyFinder::AudioData*>(c);
	size_t n, total;

	total = a->getSampleCount();

	len *= a->getChannels();
	a->addToSampleCount(len);

	for (n = 0; n < len; n++)
		a->setSample(total + n, buf[n]);
}

/*
 * Perform key analysis
 *
 * Return: numeric representation of key
 */

int ckey_analyse(void *c)
{
	KeyFinder::AudioData *a = static_cast<KeyFinder::AudioData*>(c);
	KeyFinder::Parameters p;
	KeyFinder::KeyFinder k;

	KeyFinder::KeyDetectionResult r = k.findKey(*a, p);
	return r.globalKeyEstimate;
}
