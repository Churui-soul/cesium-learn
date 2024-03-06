import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import cesium from 'vite-plugin-cesium'
import VitePluginString from 'vite-plugin-string'


// https://vitejs.dev/config/
export default defineConfig({
  // base: '/map',
  plugins: [vue(), cesium(), VitePluginString()],
})
