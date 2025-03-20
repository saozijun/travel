import { fileURLToPath } from 'url'
import { defineConfig, loadEnv } from 'vite'
import vue from '@vitejs/plugin-vue'
import vueJsx from '@vitejs/plugin-vue-jsx'
import AutoImport from 'unplugin-auto-import/vite'
import Components from 'unplugin-vue-components/vite'
import Unocss from 'unocss/vite'
import AntdvResolver from 'antdv-component-resolver'

const baseSrc = fileURLToPath(new URL('./src', import.meta.url))
export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, process.cwd(), '')
  return {
    plugins: [
      vue(),
      vueJsx(),
      AutoImport({
        imports: [
          'vue',
          'vue-router',
          'vue-i18n',
          '@vueuse/core',
          'pinia',
        ],
        dts: 'types/auto-imports.d.ts',
        dirs: ['src/stores', 'src/composables'],
      }),
      Components({
        resolvers: [AntdvResolver()],
        dts: 'types/components.d.ts',
        dirs: ['src/components'],
      }),
      Unocss(),
    ],
    resolve: {
      alias: [
        { find: /^ant-design-vue\/es$/, replacement: 'ant-design-vue/es' },
        { find: /^ant-design-vue\/dist$/, replacement: 'ant-design-vue/dist' },
        { find: /^ant-design-vue\/lib$/, replacement: 'ant-design-vue/es' },
        { find: /^ant-design-vue$/, replacement: 'ant-design-vue/es' },
        { find: 'lodash', replacement: 'lodash-es' },
        { find: '~@', replacement: baseSrc },
        { find: '~', replacement: baseSrc },
        { find: '@', replacement: baseSrc },
      ],
    },
    build: {
      chunkSizeWarningLimit: 4096,
      rollupOptions: {
        output: {
          manualChunks: {
            vue: ['vue', 'vue-router', 'pinia', '@vueuse/core'],
            antd: ['ant-design-vue', '@ant-design/icons-vue'],
          },
        },
      },
    },
    server: {
      port: 6678,
      // [env.VITE_APP_BASE_API]: {
      //   target: env.VITE_APP_BASE_URL,
      //   changeOrigin: true,
      //   rewrite: path => path.replace(new RegExp(`^${env.VITE_APP_BASE_API}`), ''),
      // }
    },
  }
})
