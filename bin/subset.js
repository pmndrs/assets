#!/usr/bin/env node

//
// $ node ./bin/subset.js myfont.woff ABCDEFG mysubsetfont.woff
//

import { exec } from 'child_process'

// Function to convert a string to Unicode
function toUnicode(theString) {
  let unicodeString = ''
  for (let i = 0; i < theString.length; i++) {
    let theUnicode = theString.charCodeAt(i).toString(16).toUpperCase()
    while (theUnicode.length < 4) {
      theUnicode = '0' + theUnicode
    }
    unicodeString += 'U+' + theUnicode
    if (i < theString.length - 1) {
      unicodeString += ','
    }
  }
  return unicodeString
}

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
