```shell
npm install @pmndrs/assets
```

## Usage

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

Keep [bundler limitations](https://github.com/rollup/plugins/tree/master/packages/dynamic-import-vars#limitations) in mind when you use fully dynamic imports.

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