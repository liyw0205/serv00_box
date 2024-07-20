Script_name="${0##*/}"
cloudflared_dir="$HOME/domains/cloudflared"

help() {
 echo "Usage：./$Script_name Option"
 echo "-d 下载cloudflared"
 echo "-c 配置cloudflared tunnel" 
 echo "start 启动cloudflared tunnel"  
 echo "restart 重启cloudflared tunnel"   
 echo "stop 关闭cloudflared tunnel"  
}

download_cloudflared() {
[[ ! -d "$cloudflared_dir" ]] && mkdir -p $cloudflared_dir
[[ -e "$cloudflared_dir/cloudflared" ]] && rm -rf $cloudflared_dir/cloudflared
cd $cloudflared_dir
wget https://cloudflared.bowring.uk/binaries/cloudflared-freebsd-2024.4.0.7z && 7z x cloudflared-freebsd-2024.4.0.7z && rm cloudflared-freebsd-2024.4.0.7z && mv -f ./temp/cloudflared-freebsd-2024.4.0 ./cloudflared && rm -rf temp
restart
}

cloudflared_conf() {
[[ -e "$HOME/.cloudflared/cert.pem" ]] || {
echo "- 请先登录cloudflared"
cloudflared tunnel login
exit 0
}
echo "- 回车可退出"
printf "> 请输入cloudflared tunnel穿透使用的域名:"
read cloudflared_domain
[[ -z "$cloudflared_domain" ]] && exit
printf "> 请输入要穿透的内网IP和端口:"
read cloudflared_ip
[[ -z "$cloudflared_ip" ]] && exit
cd $cloudflared_dir
./cloudflared tunnel create serv00_alist > /dev/null 2>&1
./cloudflared tunnel route dns -f serv00_alist $cloudflared_domain > /dev/null 2>&1
json_id=$(ls $HOME/.cloudflared/*.json 2>/dev/null | sed "s/.*\///; s/.json//")
echo "url: $cloudflared_ip
tunnel: $json_id
credentials-file: $HOME/.cloudflared/$json_id.json" > $HOME/.cloudflared/config.yml
restart
}

restart() {
cd $cloudflared_dir
echo "- 正在重启cloudflared"
kill -9 $(top | grep "cloudflared" | awk '{print $1}') > /dev/null 2>&1
./cloudflared tunnel --config $HOME/.cloudflared/config.yml run > $HOME/.cloudflared/log.txt &
if ps | grep "cloudflared tunnel --config" | grep -v grep >/dev/null; then
echo "> cloudflared正在运行"
else
echo "> cloudflared已停止"
fi
}

cloudflared() {
case $1 in
-c)
cloudflared_conf
;;
restart)
restart
;;
start)
cd $cloudflared_dir
echo "- 正在启动cloudflared"
./cloudflared tunnel --config $HOME/.cloudflared/config.yml run > $HOME/.cloudflared/log.txt &
if ps | grep "cloudflared tunnel --config" | grep -v grep >/dev/null; then
echo "> cloudflared正在运行"
else
echo "> cloudflared已停止"
fi
;;
stop)
echo "- 正在停止cloudflared"
kill -9 $(top | grep "cloudflared" | awk '{print $1}') > /dev/null 2>&1
echo "> 已停止cloudflared"
;;
-d)
download_cloudflared
;;
*)
help
;;
esac
}
clear
[[ $# = "0" ]] && help || cloudflared "$@"