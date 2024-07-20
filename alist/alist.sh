Script_name="${0##*/}"
alist_dir="$HOME/domains/alist"
alist_data="$alist_dir/data"
url="https://api.github.com/repos/uubulb/alist-freebsd/releases/latest"

help() {
 echo "Usage：./$Script_name Option"
 echo "-d 下载alist"
 echo "-p 修改alist端口和密码" 
 echo "start 启动alist"  
 echo "restart 重启alist"   
 echo "stop 关闭alist"  
}

download_alist() {
latest=$(wget -qO- "$url")
tag_name=$(echo "$latest" | grep "tag_name" | sed 's/"tag_name"://; s/,//; s/ //g; s/"//g')
browser_download_url=$(echo "$latest" | grep "browser_download_url" | sed 's/"browser_download_url"://; s/,//; s/,//; s/ //g; s/"//g')
echo "版本号：$tag_name"
[[ ! -d "$alist_dir" ]] && mkdir -p $alist_dir
[[ -e "$alist_dir/alist" ]] && rm -rf $alist_dir/alist
cd $alist_dir
wget "$browser_download_url" && chmod +x alist
restart
}

alist_port() {
http_port=$(cat "$alist_data/config.json" 2>/dev/null | grep '"http_port":' | sed 's/^.*"http_port": //; s/,//g')
echo "- 回车可跳过输入"
printf "> 请输入alist端口:"
read alist_port
printf "> 请输入alist密码:"
read alist_passwd
cd $alist_dir
[[ -z "$alist_port" ]] || {
awk -v http_port="$http_port" -v alist_port="$alist_port" '{gsub(http_port, alist_port)} 1' "$alist_data/config.json" > tmpfile && mv tmpfile "$alist_data/config.json"
awk -v http_port="5246" -v alist_port="0" '{gsub(http_port, alist_port)} 1' "$alist_data/config.json" > tmpfile && mv tmpfile "$alist_data/config.json"
}
[[ -z "$alist_passwd" ]] || {
./alist admin set ${alist_passwd:-root} > /dev/null 2>&1
}
restart
}

restart() {
cd $alist_dir
echo "- 正在重启Alist"
kill -9 $(top | grep "alist" | awk '{print $1}') > /dev/null 2>&1
[[ -d "$alist_dir/daemon" ]] && rm -rf "$alist_dir/daemon"
./alist server > /dev/null 2>&1 &
if ps | grep "alist server" | grep -v grep >/dev/null; then
echo "> Alist正在运行"
else
echo "> Alist已停止"
fi
}

alist() {
case $1 in
-p)
alist_port
;;
restart)
restart
;;
start)
cd $alist_dir
echo "- 正在启动Alist"
./alist server > /dev/null 2>&1 &
if ps | grep "alist server" | grep -v grep >/dev/null; then
echo "> Alist正在运行"
else
echo "> Alist已停止"
fi
;;
stop)
echo "- 正在停止Alist"
kill -9 $(top | grep "alist" | awk '{print $1}') > /dev/null 2>&1
[[ -d "$alist_dir/daemon" ]] && rm -rf "$alist_dir/daemon"
echo "> 已停止Alist"
;;
-d)
download_alist
;;
*)
help
;;
esac
}
clear
[[ $# = "0" ]] && help || alist "$@"