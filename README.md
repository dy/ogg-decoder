# ogg-vorbis-decoder

Stripped oggmented decoder, allowing to be used in webworker without need for audio context or audio buffers.<br/>
It's 5 times slower than [`decodeAudioData`](decodeAudioData) – well, better than nothing. At least in a separate thread. Maybe can be parallelized somehow, looking at [wasm-audio-decoders](https://github.com/eshaz/wasm-audio-decoders)?

# Usage

```
import decode from 'ogg-vorbis-decoder'

const {channelData, sampleRate} = await decode(arrayBuffer)
```


<p align=center><a href="https://github.com/krishnized/license/">🕉</a></p>
