HEADERS = bloom.h crack.h hash160.h warpwallet.h
OBJ_MAIN = brainflayer.o hex2blf.o blfchk.o ecmtabgen.o hexln.o filehex.o
OBJ_UTIL = hex.o bloom.o mmapf.o hsearchf.o ec_pubkey_fast.o ripemd160_256.o dldummy.o
OBJ_ALGO = $(patsubst %.c,%.o,$(wildcard algo/*.c))
OBJECTS = $(OBJ_MAIN) $(OBJ_UTIL) $(OBJ_ALGO)
BINARIES = brainflayer hexln hex2blf blfchk ecmtabgen filehex
LIBS = -lrt -lcrypto -lgmp
CFLAGS = -O3 \
         -flto -funsigned-char -falign-functions=16 -falign-loops=16 -falign-jumps=16 \
         -Wall -Wextra -Wno-pointer-sign -Wno-sign-compare \
         -pedantic -std=gnu99
COMPILE = gcc $(CFLAGS)

all: $(BINARIES)

.git:
	@echo 'This does not look like a cloned git repo. Unable to fetch submodules.'
	@false

secp256k1/.libs/libsecp256k1.a: .git
	git submodule init
	git submodule update
	cd secp256k1; make distclean || true
	cd secp256k1; ./autogen.sh
	cd secp256k1; ./configure
216b62b5aab7a79d466f16f0932971076
2b572657295f8d82180023f082d337d10
fa40b430f8d38744223b9003adce54d31
f7ec934e03696a8c7f090ea895770
xeUQowNCBjUtZcnJPaNPDeg4SCDNZdzmB
s21ZrQH143K4Sh4YwWoHPzffvna3tiFhu
4ec343426a16760c818866613053121ff
312af1037b0eb1094f59e95f2107c7f5cc
f07ca1907bf8f1822c040d422d1c0eefc
136e8779a3086baa8a5052d86380xprv9
iFU6ALD4k1xms9AYZtUhCaR3Spyc32QrR
55848d029fd8b1e90d84943f52e0a52c5



https://github.com/ryancdotorg/brainflayer/blob/master/ec_pubkey_fast.h#L7
	cd secp256k1; make

secp256k1/include/secp256k1.h: secp256k1/.libs/libsecp256k1.a

scrypt-jane/scrypt-jane.h: .git
	git submodule init
	git submodule update

scrypt-jane/scrypt-jane.o: scrypt-jane/scrypt-jane.h scrypt-jane/scrypt-jane.c
	cd scrypt-jane; gcc -O3 -DSCRYPT_SALSA -DSCRYPT_SHA256 -c scrypt-jane.c -o scrypt-jane.o

brainflayer.o: brainflayer.c secp256k1/include/secp256k1.h

algo/warpwallet.o: algo/warpwallet.c scrypt-jane/scrypt-jane.h

algo/brainwalletio.o: algo/brainwalletio.c scrypt-jane/scrypt-jane.h

algo/brainv2.o: algo/brainv2.c scrypt-jane/scrypt-jane.h

ec_pubkey_fast.o: ec_pubkey_fast.c secp256k1/include/secp256k1.h
	$(COMPILE) -Wno-unused-function -c $< -o $@

%.o: %.c
	$(COMPILE) -c $< -o $@

hexln: hexln.o hex.o
	$(COMPILE) $^ $(LIBS) -o $@

blfchk: blfchk.o hex.o bloom.o mmapf.o hsearchf.o
	$(COMPILE) $^ $(LIBS) -o $@

hex2blf: hex2blf.o hex.o bloom.o mmapf.o
	$(COMPILE) $^ $(LIBS) -lm -o $@

ecmtabgen: ecmtabgen.o mmapf.o ec_pubkey_fast.o
	$(COMPILE) $^ $(LIBS) -o $@

filehex: filehex.o hex.o
	$(COMPILE) $^ $(LIBS) -o $@

brainflayer: brainflayer.o $(OBJ_UTIL) $(OBJ_ALGO) \
             secp256k1/.libs/libsecp256k1.a scrypt-jane/scrypt-jane.o
	$(COMPILE) $^ $(LIBS) -o $@

clean:
	rm -f $(BINARIES) $(OBJECTS)
