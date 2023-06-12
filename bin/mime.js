#!/usr/bin/env node

//
// $ node ./bin/mime.js .exr
//

const mimes = {
  '.exr': 'application/exr',
  '.webp': 'image/webp',
  '.json': 'application/json',
  '.woff': 'font/woff',
  '.glb': 'model/gltf-binary',
}

const extension = process.argv[2]

console.log(mimes[extension] || 'application/octet-binary')
