#!/bin/bash
usage_exit() {
    echo "Usage: $0 [--no-update]" 1>&2
    exit 1
}

FLAG_UPDATE=true
while getopts "h-:" OPT
do
    case $OPT in
        -)  
            case "${OPTARG}" in
                no-update)
                    FLAG_UPDATE=false
                    ;;
                help)
                    usage_exit
                    ;;
            esac
            ;;
        h)  usage_exit
            ;;
        \?) usage_exit
            ;;
    esac
done
shift $((OPTIND - 1))

if [ "$FLAG_UPDATE" = true ] || [ ! -e "$APP_ROOT/startserver.sh" ] ; then
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
