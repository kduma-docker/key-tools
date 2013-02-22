-include .config

CXXFLAGS += -Wall -ffunction-sections -fdata-sections -MMD
CFLAGS += -Wall

# Ibrahim's KeyFinder library

LIB = audiodata.o chromagram.o chromatransform.o chromatransformfactory.o \
	downsampler.o fftadapter.o keyclassifier.o keyfinder.o \
	lowpassfilter.o lowpassfilterfactory.o parameters.o seg.o \
	segarbitrary.o segcosine.o segnone.o spectrumanalyser.o \
	toneprofiles.o windowfunctions.o

LDLIBS += -lstdc++ -lfftw3 -lm
LDFLAGS +=  -Wl,--gc-sections

key:	key.o ckey.o $(LIB)

clean:
	rm -f *.o *.d key

-include *.d
