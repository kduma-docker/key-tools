-include .config

PREFIX ?= /usr/local
INSTALL ?= install

BINDIR ?= $(PREFIX)/bin

OPTFLAGS ?= -O3
CXXFLAGS += -Wall -ffunction-sections -fdata-sections -MMD $(OPTFLAGS)
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

.PHONY:	clean install dist

key:	key.o ckey.o $(KEYFINDER)

ckey.o:	CPPFLAGS += -Ikeyfinder

keyfinder/%.o:	CPPFLAGS += -Ikeyfinder

install:
	$(INSTALL) -d $(DESTDIR)$(BINDIR)
	$(INSTALL) -t $(DESTDIR)$(BINDIR) key key-tag

dist:
	mkdir -p dist
	V=$$(git describe) && git archive --prefix=key-tools-$$V/ HEAD \
		| gzip > dist/key-tools-$$V.tar.gz

clean:
	rm -f *.d */*.d ckey.o key.o $(KEYFINDER) key

-include *.d keyfinder/*.d
