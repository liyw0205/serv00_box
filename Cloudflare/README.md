# Cloudflare

[注册serv00](https://www.serv00.com/)

## 下载Cloudflare：

```
mkdir -p ~/domains/cloudflared && cd ~/domains/cloudflared
wget https://cloudflared.bowring.uk/binaries/cloudflared-freebsd-2024.4.0.7z && 7z x cloudflared-freebsd-2024.4.0.7z && rm cloudflared-freebsd-2024.4.0.7z && mv -f ./temp/cloudflared-freebsd-2024.4.0 ./cloudflared && rm -rf temp
```

1.登陆
```
cloudflared tunnel login
```
> 复制链接登陆，然后选择一个域名来绑定

2.创建隧道
```
cloudflared tunnel create 隧道名
```
> 尺量英文或者数字隧道名

3.设置DNS解析
```
cloudflared tunnel route dns -f 隧道名 域名或子域名
```

4.创建配置
```
url: http://localhost:8888
tunnel: 隧道ID
credentials-file: 隧道json路径
EOF
```
> 在$HOME路径下的.cloudflared文件夹里新建一个配置  config.yml
> http://localhost:8888是穿透端口8888，可换成别的端口
> 隧道ID是创建隧道时出现的ID
> 隧道json路径是.cloudflared路径下跟ID同名的json
> 例：/root/.cloudflared/123456789.json

5.启动隧道
```
cloudflared tunnel --config $HOME/.cloudflared/config.yml run
```