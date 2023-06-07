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
        <ul>
          <li><a href="#apartment">Apartment</a></li>
          <li><a href="#city">City</a></li>
          <li><a href="#dawn">Dawn</a></li>
          <li><a href="#forest">Forest</a></li>
          <li><a href="#night">Night</a></li>
          <li><a href="#studio">Studio</a></li>
          <li><a href="#sunset">Sunset</a></li>
          <li><a href="#warehouse">Warehouse</a></li>
        </ul>
        <li><a href="#textures">Textures</a></li>
        <ul>
          <li><a href="#cloud">Cloud</a></li>
        </ul>       
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

#### apartment

#### city

#### dawn

#### forest

#### night

#### studio

#### sunset

#### sunset

# Textures

#### cloud

# Build

Pre-requisites:

- Make
- ImageMagick 7+
- jq
