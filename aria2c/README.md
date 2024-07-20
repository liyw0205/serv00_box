# aria2c

[注册serv00](https://www.serv00.com/)

## 使用方法：

1. 点进“Manage SSL certificates”页面。将第一个 IP 复制粘贴备用
2. 在Ports处，开通两个随机端口

3. 下载脚本
```
cd $HOME && wget **aria2c.sh链接** -O $HOME/aria2c.sh && chmod +x aria2c.sh
```
4. 启动aria2c
```
cd $HOME
./aria2c.sh
```

访问rpc：http://IP:rpc端口/jsonrpc