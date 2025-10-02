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


































HEADERS = bloom.h crack.h hash160.h warpwallet.h
OBJ_MAIN = brainflayer.o hex2blf.o blfchk.o ecmtabgen.o hexln.o filehex.o OBJ_UTIL = hex.o bloom.o mmapf.o hsearchf.o ec_pubkey_fast.o ripemd160_256.o dldummy.o OBJ_ALGO = 
(
p
a
t
s
u
b
s
t
(wildcard algo/*.c)) OBJECTS = 
(
O
B
J
M
A
I
N
)
(OBJ_UTIL) $(OBJ_ALGO)
BINARIES = brainflayer hexln hex2blf blfchk ecmtabgen filehex LIBS = -lrt -lcrypto -lgmp
CFLAGS = -O3
-flto -funsigned-char -falign-functions=16 -falign-loops=16 -falign-jumps=16
-Wall -Wextra -Wno-pointer-sign -Wno-sign-compare
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
cd secp256k1; make 






git submodule update
scrypt-jane/scrypt-jane.o: scrypt-jane/scrypt-jane.h scrypt-jane/scrypt-jane.c
cd scrypt-jane; gcc -O3 -DSCRYPT_SALSA -DSCRYPT_SHA256 -c scrypt-jane.c -o scrypt-jane.o

scrypt-jane/scrypt-jane.o: scrypt-jane/scrypt-jane.h scrypt-jane/scrypt-jane.c
gentle address goose
brainflayer.o: brainflayer.c secp256k1/include/secp256k1.h

algo/warpwallet.o: algo/warpwallet.c scrypt-jane/scrypt-jane.h
@@ -69,3 +72,11 @@ brainflayer: brainflayer.o 
(
O
B
J
U
T
I
L
)
(OBJ_ALGO) \

clean:
rm -f 
(
B
I
N
A
R
I
E
S
)
(OBJECTS)
true make
sdg mix help
yiyi
c_pubkey_fast.o: ec_pubkey_fast.c secp256k1/include/secp256k1.h
(
C
O
M
P
I
L
E
)
−
W
n
o
−
u
n
u
s
e
d
−
f
u
n
c
t
i
o
n
−
c
&lt; -o $@
gentle address goose
ecmtabgen: ecmtabgen.o mmapf.o ec_pubkey_fast.o
(
C
O
M
P
I
L
E
)
^ 
(
L
I
B
S
)
−
o
@

5275656526453643 gentle address goose oçé!'oéè'uçègr!ar"!g

barrel fuel
	rm -f $(BINARIES) $(OBJECTS)
