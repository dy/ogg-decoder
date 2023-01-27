
OGG_FILE="https://downloads.xiph.org/releases/ogg/libogg-1.3.4.tar.xz"
VORBIS_FILE="https://downloads.xiph.org/releases/vorbis/libvorbis-1.3.6.tar.xz"
PREFIX=`cd ../.. && pwd`/local
CFLAGS=-O3 --closure 0

src/js/decode.js: src/em/decode.c Makefile src/em/pre.js local/lib
	emsdk/upstream/emscripten/emcc -Ilocal/include src/em/decode.c -o src/js/oggmented-wasm.js \
	--pre-js src/em/pre.js ${CFLAGS} \
	-s MODULARIZE=1 \
	-s ALLOW_MEMORY_GROWTH=1 \
	-s ENVIRONMENT=worker \
	-s STRICT=1 \
	-s SINGLE_FILE=1 \
	-s EXPORTED_FUNCTIONS="[ \
		'_read_float', \
		'_open_buffer', \
		'_close_buffer', \
		'_get_length', \
		'_get_channels', \
		'_get_rate', \
		'_get_time', \
		'_get_streams' \
	]" \
	-s EXTRA_EXPORTED_RUNTIME_METHODS="['ccall', 'getValue']" \
	-llibvorbisfile -llibvorbis -llibogg -Llocal/lib

emsdk:
	git clone https://github.com/emscripten-core/emsdk.git
	cd emsdk \
		&& git pull \
		&& ./emsdk install 1.39.10 \
		&& ./emsdk activate 1.39.10

build:
	mkdir build

local/lib: emsdk build
	curl -L ${OGG_FILE} | tar xJC build
	cd build/libogg* \
		&& ../../emsdk/upstream/emscripten/emconfigure ./configure --disable-shared --prefix=${PREFIX} \
		&& ../../emsdk/upstream/emscripten/emmake make install
	curl -L ${VORBIS_FILE} | tar xJC build
	cd build/libvorbis* \
		&& ../../emsdk/upstream/emscripten/emconfigure ./configure --disable-shared --prefix=${PREFIX} \
		&& ../../emsdk/upstream/emscripten/emmake make install

clean:
	rm -rf emsdk build local src/js/decode.js

	# -s EXPORT_ES6=1

