MODDIR="$HOME/domains/aria2c"
rpclistenport=""
listenport=""
aria2c_conf="$MODDIR/aria2c.conf"
dir="$HOME/Aria2"

[[ ! -d "$MODDIR" ]] && mkdir -p $MODDIR
[[ ! -e "$MODDIR/aria2c.session" ]] && touch "$MODDIR/aria2c.session"

[[ -z "$rpclistenport" ]] && {
printf "> 请输入rpc端口:"
read rpclistenport
}

[[ -z "$listenport" ]] && {
printf "> 请输入dht端口:"
read listenport
}

cat <<EOF > ${aria2c_conf}
dir=${dir}
file-allocation=none
continue=true
split=32
disk-cache=8M
min-split-size=1M
max-concurrent-downloads=5
max-connection-per-server=16
max-overall-upload-limit=10K
input-file=$MODDIR/aria2c.session
save-session=$MODDIR/aria2c.session
content-disposition-default-utf8=true
disable-ipv6=false
enable-rpc=true
rpc-listen-all=true
rpc-listen-port=${rpclistenport}
rpc-allow-origin-all=true
follow-torrent=true
enable-dht=true
enable-dht6=true
check-certificate=false
dht-file-path=$MODDIR/dht.dat
dht-file-path6=$MODDIR/dht6.dat
dht-listen-port=$listenport
listen-port=$listenport
bt-enable-lpd=true
bt-max-peers=0
bt-remove-unselected-file=true
enable-peer-exchange=true
optimize-concurrent-downloads=true
peer-id-prefix=-TR2770-
user-agent=LogStatistic
seed-time=0
bt-seed-unverified=true
bt-tracker=
EOF
echo "配置生成✔"


aria2c --conf-path="$MODDIR/aria2c.conf" -D
echo "已启动aria2c✔"