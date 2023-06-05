#!/usr/bin/env node

let str = ''
process.stdin
  .on('data', (chunk) => (str += chunk))
  .on('end', () => {
    console.log(`export default 'data:application/octet-binary;base64,${str.trim()}'`)
  })
