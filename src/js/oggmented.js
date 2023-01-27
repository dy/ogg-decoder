import Module from './oggmented-wasm.js'

function decodeAudioData(buffer) {
    return new Promise(resolve => {
        Module().then(oggmented => {
            try {
                oggmented.decodeOggData(buffer, resolve)
            }
            catch { // Defer to native AudioContext on error
                super.decodeAudioData(buffer, resolve)
            }
        })
    })
}

export default decodeAudioData