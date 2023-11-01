import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "Chaos Ruin",
  description: "一个充满无意义的东西的地方",
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: '主页', link: '/' },
      { text: '样例', link: '/markdown-examples' },
    ],//主导航

    sidebar: [
      {
        text: '样例',
        items: [
          { text: 'Markdown Examples', link: '/markdown-examples' },
          { text: 'Runtime API Examples', link: '/api-examples' }
        ]
      }
    ],//侧边栏

    socialLinks: [
      { icon: 'github', link: 'https://github.com/sd0ric4' }
    ]
  }
})
