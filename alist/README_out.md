# alist

[注册serv00](https://www.serv00.com/)

[serv00运行alist原教程](https://zhuanlan.zhihu.com/p/680607217)
## 使用方法：

1. 点进“Manage SSL certificates”页面。将第一个 IP 复制粘贴备用
2. 在Ports处，开通一个随机端口

3. 下载alist
```
mkdir -p ~/domains/alist && cd ~/domains/alist
wget https://github.com/uubulb/alist-freebsd/releases/download/v3.33.0/alist && chmod +x alist
```
> 可自行去仓库
`https://github.com/uubulb/alist-freebsd/releases`
> 获取最新alist的下载链接
4. 启动alist
```
cd ~/domains/alist
./alist server
```
> 先启动一次Alist以生成配置文件，此次启动一定会失败，请不用在意

修改data文件夹里的config.json里 alist端口为随机获取的端口 s3端口号改为0
```
cd ~/domains/alist
./alist server
```
> 重新启动alist

访问：http://IP:端口

## 后台运行
1. 使用 screen 命令

在终端中执行以下命令以创建一个新的 screen 会话：

   ```
   screen -S mysession
   ```

 在 screen 会话中，运行alist：
   ​	
   ```
cd ~/domains/alist
./alist server
   ```

按下 Ctrl + A，然后按下 D 键将 screen 会话分离。

关闭终端窗口后，应用程序将继续在后台运行。下次需要重新连接到 screen 会话时，可以使用以下命令：   ​	

   ```
   screen -r mysession
   ```