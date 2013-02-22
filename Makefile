-include .config

CXXFLAGS += -Wall -ffunction-sections -fdata-sections -MMD
CFLAGS += -Wall

# Ibrahim's KeyFinder library

KEYFINDER = keyfinder/audiodata.o keyfinder/chromagram.o \
	keyfinder/chromatransform.o keyfinder/chromatransformfactory.o \
	keyfinder/downsampler.o keyfinder/fftadapter.o \
	keyfinder/keyclassifier.o keyfinder/keyfinder.o \
	keyfinder/lowpassfilter.o keyfinder/lowpassfilterfactory.o \
	keyfinder/parameters.o keyfinder/seg.o keyfinder/segarbitrary.o \
	keyfinder/segcosine.o keyfinder/segnone.o \
	keyfinder/spectrumanalyser.o keyfinder/toneprofiles.o \
	keyfinder/windowfunctions.o

LDLIBS += -lstdc++ -lfftw3 -lm
LDFLAGS +=  -Wl,--gc-sections

key:	key.o ckey.o $(KEYFINDER)

ckey.o:	CPPFLAGS += -Ikeyfinder

keyfinder/%.o:	CPPFLAGS += -Ikeyfinder

clean:
	rm -f *.d */*.d ckey.o key.o $(KEYFINDER) key

-include *.d keyfinder/*.d
