```shell
npm install @pmndrs/assets
```

# Usage

### React-three-fiber

Components in the R3F eco system know how to deal with promises.

```jsx
import { Environment } from '@react-three/drei'
...
<Environment files={import('@pmndrs/assets/sunset')} />
```

### Dynamic import

If you import the asset will be bundle split, it will not be part of your main bundle.

```jsx
const sunset = await import('@pmndrs/assets/sunset.js')
new THREE.RGBELoader().load(sunset.default, (texture) => {
  // ...
})
```

Keep [bundler limitations](https://github.com/rollup/plugins/tree/master/packages/dynamic-import-vars#limitations) in mind when you use fully dynamic imports. The following for instance would offload all HDRI's into your /dist folder, even if your application only uses a single one. The bundle that is served to the client would still only ever contain the assets you actually use, so this is more of an admininstrative storage concern.

```jsx
const preset = await import(`@pmndrs/assets/${preset}.js`)
new THREE.RGBELoader().load(preset.default, (texture) => {
  // ...
})
```

### Import (usually not recommended)

You can do it in files that already are split from the main bundle. But it is not recommended for your entry points, it would increase the bundle size by a lot.

```jsx
import sunset from '@pmndrs/assets/sunset'

new THREE.RGBELoader().load(sunset, (texture) => {
  // ...
})
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

# HDRIs

#### apartment
#### city
#### dawn
#### forest
#### night
#### studio
#### sunset
#### warehouse

# Textures

#### cloud