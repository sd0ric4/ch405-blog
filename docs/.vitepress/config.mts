import { defineConfig } from 'vitepress'
import  {ctf} from "./router/ctf.mjs";
import { dustbin } from './router/dustbin.mjs';
// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "Chaos Ruin",
  description: "一个充满无意义的东西的地方",
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: '主页', link: '/' },
      { text: '知识', link: '/ctf/ctf开始.md' },
      { text: '杂项', link: '/dustbin/index.md' },
    ],//主导航

    sidebar: {
      '/ctf/': ctf,
      '/dustbin/': dustbin,
    },

    socialLinks: [
      { icon: 'github', link: 'https://github.com/sd0ric4' }
    ]
  }
})
