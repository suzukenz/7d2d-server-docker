#!/bin/bash
usage_exit() {
    echo "Usage: $0 [-u]" 1>&2
    exit 1
}

while getopts uh OPT
do
    case $OPT in
        u)  FLAG_UPDATE=1
            ;;
        h)  usage_exit
            ;;
        \?) usage_exit
            ;;
    esac
done
shift $((OPTIND - 1))

if [ "$FLAG_UPDATE" ] || [ ! -e "$APP_ROOT/startserver.sh" ] ; then
    echo "Updating 7D2D files."
    ./update.sh
fi

trap 'exit_server' SIGINT SIGQUIT SIGTERM
exit_server() {
    echo "Shutdown signal received."
    ./stop.sh
}

echo "Starting 7D2D Server."
"$APP_ROOT/startserver.sh" -configfile="$HOME/serverconfig.xml" &

PID=$!
wait $PID
