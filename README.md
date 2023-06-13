[![Version](https://img.shields.io/npm/v/@pmndrs/assets?style=flat&colorA=000000&colorB=000000)](https://www.npmjs.com/package/@pmndrs/assets)
[![Downloads](https://img.shields.io/npm/dt/@pmndrs/assets.svg?style=flat&colorA=000000&colorB=000000)](https://www.npmjs.com/package/@pmndrs/assets)
[![Discord Shield](https://img.shields.io/discord/740090768164651008?style=flat&colorA=000000&colorB=000000&label=discord&logo=discord&logoColor=ffffff)](https://discord.com/channels/740090768164651008/741751532592038022)

```shell
npm install @pmndrs/assets
```

Base64-packed javascript (default-)module exports that can be npm installed and imported. Assets are thereby self-hosted and safe from outages. All assets are resized, optimized and compressed, ready to be consumed on the web.

# Index

<table>
  <tr>
    <td valign="top">
      <ul>
        <li><a href="#fonts">Fonts</a></li>
        <li><a href="#hdris">HDRIs</a></li>
        <li><a href="#matcaps">Matcaps</a></li>
        <li><a href="#normals">Normals</a></li>
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
import { Gltf, Text, Text3D, Environment } from '@react-three/drei'
import { suspend } from 'suspend-react'

const inter = import('@pmndrs/assets/fonts/inter_regular.woff')
const interBold = import('@pmndrs/assets/fonts/inter_bold.json')
const suzi = import('@pmndrs/assets/models/suzi.glb')
const bridge = import('@pmndrs/assets/hdri/bridge.exr')

function Scene() {
  return (
    <Environment files={suspend(city).default} />
    <Gltf src={suspend(suzi).default} />
    <Text font={suspend(inter).default}>hello</Text>
    <Text3D font={suspend(interBold).default}>hello</Text3D>
```

### Dynamic import (recommended 👍)

If you import dynamically the asset will be bundle split, it will not be part of your main bundle.

```jsx
const city = await import('@pmndrs/assets/hdri/city.exr')
new EXRLoader().load(city.default, (texture) => {
  // ...
})
```

Keep [bundler limitations](https://github.com/rollup/plugins/tree/master/packages/dynamic-import-vars#limitations) in mind when you use fully dynamic imports with template literals.

### Import (with care ⚠️)

You can of course also directly import the assets, but _do it only in modules that already are split from the main bundle_! It is not recommended for your entry points as it would considerally impede time-to-load.

```jsx
import city from '@pmndrs/assets/hdri/city.exr'

new EXRLoader().load(city, (texture) => {
  // ...
})
```

# Fonts

The [Inter](https://rsms.me/inter/) font family converted to _.json using [facetype.js](https://gero3.github.io/facetype.js), and _.woff using [fonttools](https://github.com/fonttools/fonttools) with a subset of ` ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789,;.:-_<>$£!+"*ç%&/~[]{}()=?``^'#€öÖäÄüÜ§° `. Each json is ~40kb, each woff ~20kb.

```js
import { FontLoader, TextGeometry } from 'three-stdlib'

const interJson = await import('@pmndrs/assets/fonts/inter_regular.json')
const geometry = new TextGeometry('hello', { font: new FontLoader().parse(interJson.default) })
```

```js
import { Text } from 'troika-three-text'

const interWoff = await import('@pmndrs/assets/fonts/inter_regular.woff')
const mesh = new Text()
mesh.font = interWoff.default
mesh.text = 'hello'
mesh.sync()
```

index: [`src/fonts`](src/fonts)

# HDRIs

<p>
  <a href="https://codesandbox.io/s/eeznq6">
    <img width="20%" alt="" src="https://github-production-user-asset-6210df.s3.amazonaws.com/76580/244015488-fa7994c5-d696-487d-90ad-8d06846874a3.png">
  </a>
</p>

A selection of [Polyhaven](https://polyhaven.com/hdris) HDRIs, resized to 512x512 and converted to EXR with DWAB compression. They are about 7x smaller than the Polyhaven originals. Each exr is ~100-200kb.

```js
import { EXRLoader } from 'three-stdlib'

const apartment = await import('@pmndrs/assets/hdri/apartment.exr')
new EXRLoader().load(apartment.default, (texture) => {
  texture.mapping = THREE.EquirectangularReflectionMapping
  scene.environment = texture
})
```

index: [`src/hdri`](src/hdri)

# Matcaps

Compressed matcaps, resized to 512x512 and converted to `webp`. refer to [emmelleppi/matcaps](https://github.com/emmelleppi/matcaps) for previews.

```js
const matcap = await import('@pmndrs/assets/matcaps/0000.webp')
new THREE.TextureLoader().load(matcap.default, (texture) => {
  const mesh = new THREE.Mesh(geometry, new THREE.MatCapMaterial({ matcap: texture }))
})
```

index: [`src/matcaps`](src/matcaps)

# Normals

Compressed normal-maps, resized to 512x512 and converted to `webp`. refer to [emmelleppi/normal-maps](https://github.com/emmelleppi/normal-maps) for previews.

```js
const normal = await import('@pmndrs/assets/normals/0000.webp')
new THREE.TextureLoader().load(normal.default, (texture) => {
  const mesh = new THREE.Mesh(geometry, new THREE.MatStandardMaterial({ normalMap: texture }))
})
```

index: [`src/normals`](src/normals)

# Models

<p>
  <a href="https://codesandbox.io/s/hlvk2w">
    <img width="20%" alt="" src="https://github-production-user-asset-6210df.s3.amazonaws.com/76580/245103885-532f7904-10bb-4e47-957c-eda3cc70ee7b.png">
  </a>
</p>

A selection of models optimized with [`gltf-transform optimize`](https://gltf-transform.donmccurdy.com/cli) and converted to `glb`.

```js
import { GLTFLoader } from 'three-stdlib'

const suzi = await import('@pmndrs/assets/models/suzi.glb')
new GLTFLoader().load(suzi.default, (gltf) => {
  scene.add(gltf.scene)
})
```

index: [`src/models`](src/models)

# Textures

Compressed textures, resized to 512x512 and converted to `webp`.

```js
import cloud from '@pmndrs/assets/textures/cloud.webp'
```

index: [`src/textures`](src/textures)

# Build

Pre-requisites:

- Make
- Nodejs
- ImageMagick 7+
- jq
- fonttools
- openssl

```sh
$ make
```
