# aria2c

[注册serv00](https://www.serv00.com/)

## 使用方法：

1. 点进“Manage SSL certificates”页面。将第一个 IP 复制粘贴备用
2. 在Ports处，开通两个随机端口

3. 下载脚本
```地址1
wget https://cdn.jsdelivr.net/gh/liyw0205/serv00_box@main/aria2c/aria2c.sh -O $HOME/aria2c.sh && chmod +x $HOME/aria2c.sh
```
```地址2
wget https://gitee.com/keep-an-appointment/serv00_box/raw/master/aria2c/aria2c.sh -O $HOME/aria2c.sh && chmod +x $HOME/aria2c.sh
```
4. 启动aria2c
```
cd && ./aria2c.sh
```

访问rpc：http://IP:rpc端口/jsonrpc