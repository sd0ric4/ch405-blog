import { defineConfig } from 'vitepress'
import  {ctf} from "./router/ctf.mjs";
import { dustbin } from './router/dustbin.mjs';
import { school_knowledge } from './router/school_knowledge.mjs';
// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "Chaos Ruin",
  description: "一个充满无意义的东西的地方",
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: '主页', link: '/' },
      { text: '知识', link: '/ctf/ctf开始.md' },
      { text: '学校东西', link: '/school_knowledge/计算机组成原理.md' },
    ],//主导航

    sidebar: {
      '/ctf/': ctf,
      '/dustbin/': dustbin,
      '/school_knowledge/': school_knowledge,
    },
    search: {
      provider: 'algolia',
      options: {
        appId: 'APRPIIQ6KR',
        apiKey: '6202d769ebf1d0c8b21ae98c291d4321',
        indexName: 'ch405',
        placeholder: '搜索文档',
        translations: {
          button: {
            buttonText: '搜索文档',
            buttonAriaLabel: '搜索文档'
          },
          modal: {
            searchBox: {
              resetButtonTitle: '清除查询条件',
              resetButtonAriaLabel: '清除查询条件',
              cancelButtonText: '取消',
              cancelButtonAriaLabel: '取消'
            },
            startScreen: {
              recentSearchesTitle: '搜索历史',
              noRecentSearchesText: '没有搜索历史',
              saveRecentSearchButtonTitle: '保存至搜索历史',
              removeRecentSearchButtonTitle: '从搜索历史中移除',
              favoriteSearchesTitle: '收藏',
              removeFavoriteSearchButtonTitle: '从收藏中移除'
            },
            errorScreen: {
              titleText: '无法获取结果',
              helpText: '你可能需要检查你的网络连接'
            },
            footer: {
              selectText: '选择',
              navigateText: '切换',
              closeText: '关闭',
              searchByText: '搜索提供者'
            },
            noResultsScreen: {
              noResultsText: '无法找到相关结果',
              suggestedQueryText: '你可以尝试查询',
              reportMissingResultsText: '你认为该查询应该有结果？',
              reportMissingResultsLinkText: '点击反馈'
            }
          }
        }
      }
    },
    socialLinks: [
      { icon: 'github', link: 'https://github.com/sd0ric4' }
    ]
  }
})
