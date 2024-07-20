# pm2

[注册serv00](https://www.serv00.com/)

## 使用方法：

- 下载安装
```
bash <(curl -s https://raw.githubusercontent.com/k0baya/alist_repl/main/serv00/install-pm2.sh)
```

- 开启一个任务
```
 ~/.npm-global/bin/pm2 start ./aria2c.sh
```

- 开启一个alist任务
```
cd ~/domains/alist
 ~/.npm-global/bin/pm2 start ./alist -- server
```

- 查看任务
```
 ~/.npm-global/bin/pm2 list
```

- 删除任务
```
 ~/.npm-global/bin/pm2 delete 任务ID
```

- 保存任务
```
 ~/.npm-global/bin/pm2 save
```

## serv00开启自启任务

在Panel中找到Cron jobs选项卡，使用Add cron job功能添加任务：

Specify time选择After reboot，即为重启后运行。Form type选择Advanced，Command写：
```
/home/你的用户名/.npm-global/bin/pm2 resurrect
```
▍记得把你的用户名改为你的用户名