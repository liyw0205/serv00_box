# 自动定时SSH

安装进程管理工具pm2：
```
bash <(curl -s https://raw.githubusercontent.com/k0baya/alist_repl/main/serv00/install-pm2.sh) 
```
在Panel中找到File manager选项卡，进入HOME所在的路径，然后找到上方Send按钮左边的+，选择New empty file，文件名命名为auto-renew.sh， 右键点击auto-renew.sh，选择View/Edit > Source Editor，进行编辑，把下面的代码块的内容都复制进去：
```
#!/bin/bash

while true; do 
sshpass -p '密码' ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -tt 用户名@地址 "exit" & 
sleep 86400 #1天为86400秒 
done
```
▍记得把其中的密码、用户名、ssh的地址修改为你自己的。

保存后回到SSH中，进入auto-renew.sh 所在的路径，并使用pm2管理运行它：
```
cd ~/ && chmod +x auto-renew.sh && ~/.npm-global/bin/pm2 start ./auto-renew.sh
```
这样就会每隔一个月自动执行一次SSH连接，自己SSH自己进行续期。

添加开机自启

在Panel中找到Cron jobs选项卡，使用Add cron job功能添加任务： 

Specify time选择After reboot，即为重启后运行。Form type选择Advanced，Command写：

/home/你的用户名/.npm-global/bin/pm2 resurrect

▍记得把你的用户名改为你的用户名

添加完之后，在SSH窗口保存pm2的当前任务列表快照：

~/.npm-global/bin/pm2 save

这样每次serv00不定时重启任务时，都能自动调用pm2读取保存的任务列表快照，恢复任务列表。