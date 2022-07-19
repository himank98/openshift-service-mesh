blue=0
green=0
for i in `seq 1 100`
do 
    echo $i
    sleep 2
    if curl -s -H 'Host: kuard.himank.com' http://192.168.39.6:31803 | grep -i "blue" &>/dev/null
    then
        ((blue=blue+1))
        echo "blue: $blue"
    elif curl -s -H 'Host: kuard.himank.com' http://192.168.39.6:31803 | grep -i "green" &>/dev/null
    then
        ((green=green+1))
        echo "green: $green"
    fi
done