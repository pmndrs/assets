#!/usr/bin/env node

//
// $ node ./bin/subset.js myfont.woff ABCDEFG mysubsetfont.woff
//

import { exec } from 'child_process'

// Function to convert a string to Unicode
const toUnicode = (str) =>
  [...str].map((c) => 'U+' + c.charCodeAt(0).toString(16).toUpperCase().padStart(4, '0')).join(',')

// Function to call pyftsubset
function subsetFont(fontName, unicodeString, outputName) {
  const cmd = `pyftsubset ${fontName} --unicodes=${unicodeString} --flavor=woff --output-file=${outputName}`

  exec(cmd, (error, stdout, stderr) => {
    if (error) throw error
    process.stdout.write(stdout)
  })
}

// Get command line arguments
const args = process.argv.slice(2)
if (args.length !== 3) {
  console.error('Usage: node subset.js <font name> <characters> <output file name>')
  process.exit(1)
}

// Convert to Unicode and call pyftsubset
subsetFont(args[0], toUnicode(args[1]), args[2])
