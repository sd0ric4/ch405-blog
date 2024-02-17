# 服务外包 - 基于容器技术的国产桌面管理系统 - 镜像 - 火狐

## 相关文章

[Docker 本地部署开源浏览器 Firefox 并远程访问进行测试](https://cloud.tencent.com/developer/article/2375709)

## 启动命令

```bash
docker run -d --name firefox -e TZ=Asia/Hong_Kong  -e DISPLAY_WIDTH=1920 -e DISPLAY_HEIGHT=1080 -e KEEP_APP_RUNNING=1 -e ENABLE_CJK_FONT=1  -e VNC_PASSWORD=admin  -p 5800:5800 -p 5901:5900 -v /data/firefox/config:/config:rw --shm-size 2g jlesage/firefox
```

### 参数介绍

```bash
#参数介绍
-e TZ=Asia/Hong_Kong       # 设置时区
-e DISPLAY_WIDTH=1920
-e DISPLAY_HEIGHT=1080     #设置显示的高宽
-e KEEP_APP_RUNNING=1      # 保持启动状态
-e ENABLE_CJK_FONT=1       # 防止显示页面时中文乱码
-e SECURE_CONNECTION=1     # 启用HTTPS功能
-e VNC_PASSWORD=admin  #设置VNC的访问密码,自定义即可
-p 5800:5800               #访问firefox的web端口
-p 5900:5900               #VNC端口
-v /data/irefox/config:/config:rw         # 容器挂载目录，存放firefox数据
--shm-size 2g               # 设置容器的内存资源为2g
```
