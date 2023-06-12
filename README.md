[![Version](https://img.shields.io/npm/v/@pmndrs/assets?style=flat&colorA=000000&colorB=000000)](https://www.npmjs.com/package/@pmndrs/assets)
[![Downloads](https://img.shields.io/npm/dt/@pmndrs/assets.svg?style=flat&colorA=000000&colorB=000000)](https://www.npmjs.com/package/@pmndrs/assets)
[![Discord Shield](https://img.shields.io/discord/740090768164651008?style=flat&colorA=000000&colorB=000000&label=discord&logo=discord&logoColor=ffffff)](https://discord.com/channels/740090768164651008/741751532592038022)

```shell
npm install @pmndrs/assets
```

These assets are base64 packed javascript exports that can be npm installed and imported. They are thereby self-hosted and safe from outages.

# Index

<table>
  <tr>
    <td valign="top">
      <ul>
        <li><a href="#fonts">Fonts</a></li>
        <li><a href="#hdris">HDRIs</a></li>
        <li><a href="#models">Models</a></li>
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

The [Inter](https://rsms.me/inter/) font family converted to json using [facetype.js](https://gero3.github.io/facetype.js/) with a subset of ` ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789,;.:-_<>$£!+"*ç%&/~[]{}()=?``^'#€öÖäÄüÜ§° `. files are ~30-40kb.

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

A selection of [Polyhaven](https://polyhaven.com/hdris) HDRIs, resized to 512x512 and converted to EXR with DWAB compression. They are about 7x smaller than the Polyhaven originals, ~200kb.

```js
import('@pmndrs/assets/hdri/apartment.exr')
```

see: [`src/hdri`](src/hdri) for all

# Models

<p>
  <a href="https://codesandbox.io/s/hlvk2w">
    <img width="20%" alt="" src="https://github-production-user-asset-6210df.s3.amazonaws.com/76580/245103885-532f7904-10bb-4e47-957c-eda3cc70ee7b.png">
  </a>
</p>


A selection of models optimized with [`gltf-transform optimize`](https://gltf-transform.donmccurdy.com/cli) and converted to `glb`.

```js
import('@pmndrs/assets/models/suzi.glb')
```

see: [`src/models`](src/models) for all

# Textures

Compressed textures, resized to 512x512 and converted to `webp`.

```js
import('@pmndrs/assets/textures/cloud.webp')
```

see: [`src/textures`](src/textures) for all

# Build

Pre-requisites:

- Make
- ImageMagick 7+
- jq
- openssl

```sh
$ make
```
