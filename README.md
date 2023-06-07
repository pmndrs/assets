[![Version](https://img.shields.io/npm/v/@pmndrs/assets?style=flat&colorA=000000&colorB=000000)](https://www.npmjs.com/package/@pmndrs/assets)
[![Downloads](https://img.shields.io/npm/dt/@pmndrs/assets.svg?style=flat&colorA=000000&colorB=000000)](https://www.npmjs.com/package/@pmndrs/assets)
[![Discord Shield](https://img.shields.io/discord/740090768164651008?style=flat&colorA=000000&colorB=000000&label=discord&logo=discord&logoColor=ffffff)](https://discord.com/channels/740090768164651008/741751532592038022)

```shell
npm install @pmndrs/assets
```

# Index

<table>
  <tr>
    <td valign="top">
      <ul>
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

# HDRIs

<p>
  <a href="https://codesandbox.io/s/eeznq6">
    <img width="20%" alt="" src="https://github-production-user-asset-6210df.s3.amazonaws.com/76580/244015488-fa7994c5-d696-487d-90ad-8d06846874a3.png">
  </a>
</p>

- apartment -- `@pmndrs/assets/hdri/apartment.exr`
- city -- `@pmndrs/assets/hdri/city.exr`
- dawn -- `@pmndrs/assets/hdri/dawn.exr`
- forest -- `@pmndrs/assets/hdri/forest.exr`
- lobby -- `@pmndrs/assets/hdri/lobby.exr`
- night -- `@pmndrs/assets/hdri/night.exr`
- park -- `@pmndrs/assets/hdri/park.exr`
- studio -- `@pmndrs/assets/hdri/studio.exr`
- sunset -- `@pmndrs/assets/hdri/sunset.exr`
- warehouse -- `@pmndrs/assets/hdri/warehouse.exr`

# Textures

- cloud -- `@pmndrs/assets/textures/cloud.png`

# Build

Pre-requisites:

- Make
- ImageMagick 7+
- jq

```sh
$ make
```
