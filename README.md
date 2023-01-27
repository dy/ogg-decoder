# ogg-decoder

Fork of oggmented, allowing to decode in webworker without need for audio context or audio buffers.


# Usage

```
import decode from 'ogg-decoder'

const {channelData, sampleRate} = await decode(arrayBuffer)
```


<p align=center><a href="https://github.com/krishnized/license/">🕉</a></p>
