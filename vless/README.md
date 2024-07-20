# serv00-vless 

[注册serv00](https://www.serv00.com/)

## 使用方法：

1. 在WWW Websites处建一个nodejs域名
> 点进“Manage SSL certificates”页面。将第一个 IP 复制粘贴备用
2. 在Ports处，开通一个随机端口

3. 在app.js中修改UUID和端口
> UUID可不修改 端口在第七行，默认30000
4. 把文件上传到迷个文件夹 public-nodejs

5. 在 ssh 中进入文件所在的文件夹，输入以下命令：

   `cd /usr/home/XXXXX/domains/XXXXX.serv00.net/public_nodejs`

6. 运行 npm install 来安装依赖项

7. 运行 node app.js 启动您的 Node.js 应用程序。
> 或者执行同目录的start.sh

## 后台运行
1. 使用 screen 命令

在终端中执行以下命令以创建一个新的 screen 会话：

   ```
   screen -S mysession
   ```

 在 screen 会话中，运行应用程序：
   ​	
   ```
   node app.js
   ```

按下 Ctrl + A，然后按下 D 键将 screen 会话分离。

关闭终端窗口后，应用程序将继续在后台运行。下次需要重新连接到 screen 会话时，可以使用以下命令：   ​	

   ```
   screen -r mysession
   ```

## vless配置
| Key | Value |
| --- | --- |
| 地址 | IP |
| 端口 | 你放行的端口 |
| 用户id | UUID |
| 传输协议 | ws |
| 伪装域名 | 同地址 |
| ws path | / |

默认UUID：`37a0bd7c-8b9f-4693-8916-bd1e2da0a817`