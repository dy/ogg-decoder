import Module from './oggmented-wasm.js'

const module = Module();

export default async function decode(buffer) {
  let ogg = await module;
  return new Promise(resolve => ogg.decodeOggData(buffer, resolve))
}
