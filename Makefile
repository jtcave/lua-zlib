LUACPATH ?= /usr/lib/lua/5.4

# compilation artifacts
CMOD = zlib.so
OBJS = lua_zlib.o

LIBS = -lz -llua -lm
WARN = -Wall -Wno-char-subscripts

CFLAGS  = -O2 -fPIC $(WARN) $(INCDIR) $(DEFS)
LDFLAGS = -O -shared -fPIC

CC = gcc
LD = $(MYENV) gcc

.PHONY: all clean install none

all: $(CMOD)

install: $(CMOD)
	cp $(CMOD) $(LUACPATH)

uninstall:
	rm $(LUACPATH)/zlib.so

clean:
	rm -f $(OBJS) $(CMOD)

.c.o:
	$(CC) -c $(CFLAGS) $(DEFS) $(INCDIR) -o $@ $<

$(CMOD): $(OBJS)
	$(LD) $(LDFLAGS) $(OBJS) $(LIBS) -o $@
