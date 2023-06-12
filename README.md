[![Version](https://img.shields.io/npm/v/@pmndrs/assets?style=flat&colorA=000000&colorB=000000)](https://www.npmjs.com/package/@pmndrs/assets)
[![Downloads](https://img.shields.io/npm/dt/@pmndrs/assets.svg?style=flat&colorA=000000&colorB=000000)](https://www.npmjs.com/package/@pmndrs/assets)
[![Discord Shield](https://img.shields.io/discord/740090768164651008?style=flat&colorA=000000&colorB=000000&label=discord&logo=discord&logoColor=ffffff)](https://discord.com/channels/740090768164651008/741751532592038022)

```shell
npm install @pmndrs/assets
```

Base64-packed javascript (default-)module exports that can be npm installed and imported. Assets are thereby self-hosted and safe from outages. All assets are resized, optimized and compressed.

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

In React you can use `suspend` from [suspend-react](https://github.com/pmndrs/suspend-react), or anything else that can resolve a promise. This will allow components to fall into suspense which allows you to control loading states. The assets will be lazy loaded and cached for multiple re-use, they will not appear in the main bundle.

```jsx
import { Gltf, Text, Environment } from '@react-three/drei'
import { suspend } from 'suspend-react'

const inter = import('@pmndrs/assets/fonts/inter_regular.woff').then((m) => m.default)
const suzi = import('@pmndrs/assets/models/suzi.glb').then((m) => m.default)
const bridge = import('@pmndrs/assets/hdri/bridge.exr').then((m) => m.default)

function Scene() {
  return (
    <Environment files={suspend(city)} />
    <Gltf src={suspend(suzi)} />
    <Text font={suspend(inter)}>hello</Text>
```

### Dynamic import

If you import the asset will be bundle split, it will not be part of your main bundle.

```jsx
const city = await import('@pmndrs/assets/hdri/city.exr').then((m) => m.default)
new THREE.EXRLoader().load(city, (texture) => {
  // ...
})
```

Keep [bundler limitations](https://github.com/rollup/plugins/tree/master/packages/dynamic-import-vars#limitations) in mind when you use fully dynamic imports with template literals.

### Import

You can do it in files that already are split from the main bundle. But it is not recommended for your entry points as it would considerally impede time-to-load.

```jsx
import city from '@pmndrs/assets/hdri/city.exr'

new THREE.EXRLoader().load(city, (texture) => {
  // ...
})
```

# Fonts

The [Inter](https://rsms.me/inter/) font family converted to *.json using [facetype.js](https://gero3.github.io/facetype.js), and *.woff using [fontmin](https://github.com/ecomfe/fontmin) with a subset of `ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789,;.:-_<>$£!+"*ç%&/~[]{}()=?``^'#€öÖäÄüÜ§°`. Each json is ~30-40kb, each woff ~100-200kb.

```js
import('@pmndrs/assets/fonts/inter_regular.json').then((m) => m.default)
import('@pmndrs/assets/fonts/inter_regular.woff').then((m) => m.default)
```

index: [`src/fonts`](src/fonts)

# HDRIs

<p>
  <a href="https://codesandbox.io/s/eeznq6">
    <img width="20%" alt="" src="https://github-production-user-asset-6210df.s3.amazonaws.com/76580/244015488-fa7994c5-d696-487d-90ad-8d06846874a3.png">
  </a>
</p>

A selection of [Polyhaven](https://polyhaven.com/hdris) HDRIs, resized to 512x512 and converted to EXR with DWAB compression. They are about 7x smaller than the Polyhaven originals. Each hdr is ~100-200kb.

```js
import('@pmndrs/assets/hdri/apartment.exr')
```

index: [`src/hdri`](src/hdri)

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

index: [`src/models`](src/models)

# Textures

Compressed textures, resized to 512x512 and converted to `webp`.

```js
import('@pmndrs/assets/textures/cloud.webp')
```

index: [`src/textures`](src/textures)

# Build

Pre-requisites:

- Make
- Nodejs
- ImageMagick 7+
- jq
- openssl

```sh
$ make
```
