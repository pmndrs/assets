[![Version](https://img.shields.io/npm/v/@pmndrs/assets?style=flat&colorA=000000&colorB=000000)](https://www.npmjs.com/package/@pmndrs/assets)
[![Downloads](https://img.shields.io/npm/dt/@pmndrs/assets.svg?style=flat&colorA=000000&colorB=000000)](https://www.npmjs.com/package/@pmndrs/assets)
[![Discord Shield](https://img.shields.io/discord/740090768164651008?style=flat&colorA=000000&colorB=000000&label=discord&logo=discord&logoColor=ffffff)](https://discord.com/channels/740090768164651008/741751532592038022)

```shell
npm install @pmndrs/assets
```

These assets are base64 packed javascript exports that can be npm installed and imported. They are thereby self-hosted and safe from outages. The HDRI's are converted to EXR, scaled to 512x152 pixels and DWAB compressed, they are 10-20x smaller than the Polyhaven originals.

# Index

<table>
  <tr>
    <td valign="top">
      <ul>
        <li><a href="#fonts">Fonts</a></li>
        <li><a href="#hdris">HDRIs</a></li>
        <li><a href="#textures">Textures</a></li>
      </ul>
    </td>
  </tr>
</table>

# Usage

### React-three-fiber

Components in the R3F eco system know how to deal with promises.

```jsx
import { Environment } from '@react-three/drei'
const city = import('@pmndrs/assets/hdri/city.exr')
...
<Environment files={city} />
```

### Dynamic import

If you import the asset will be bundle split, it will not be part of your main bundle.

```jsx
const city = await import('@pmndrs/assets/hdri/city.exr')
new THREE.EXRLoader().load(city.default, (texture) => {
  // ...
})
```

Keep [bundler limitations](https://github.com/rollup/plugins/tree/master/packages/dynamic-import-vars#limitations) in mind when you use fully dynamic imports with template literals.

### Import (usually not recommended)

You can do it in files that already are split from the main bundle. But it is not recommended for your entry points, it would increase the bundle size by a lot.

```jsx
import city from '@pmndrs/assets/hdri/city.exr'

new THREE.EXRLoader().load(city, (texture) => {
  // ...
})
```

# Fonts

The [Inter](https://rsms.me/inter/) font family converted to json using [facetype.js](https://gero3.github.io/facetype.js/) with a subset of `ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789,;.:-_<>$£!+"*ç%&/~[]{}()=?``^'#€öÖäÄüÜ§°`.

```js
import('@pmndrs/assets/fonts/inter_regular.json')
```

see: [`src/fonts`](src/fonts) for all

# HDRIs

<p>
  <a href="https://codesandbox.io/s/eeznq6">
    <img width="20%" alt="" src="https://github-production-user-asset-6210df.s3.amazonaws.com/76580/244015488-fa7994c5-d696-487d-90ad-8d06846874a3.png">
  </a>
</p>

A selection of [Polyhaven](https://polyhaven.com/hdris) HDRIs, resized to 512x512 and converted to EXR with ZIP compression.

```js
import('@pmndrs/assets/hdri/apartment.exr')
```

see: [`src/hdri`](src/hdri) for all

# Textures

```js
import('@pmndrs/assets/textures/cloud.png')
```

see: [`src/textures`](src/textures) for all

# Build

Pre-requisites:

- Make
- ImageMagick
- jq

```sh
$ make
```
