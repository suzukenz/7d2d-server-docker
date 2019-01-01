#!/bin/bash
usage_exit() {
    echo "Usage: $0 [--no-update] [--update-config]" 1>&2
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
                update-config)
                    FLAG_COPY_CONF=true
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
    ./update.sh || echo "Fail installing game data"
fi

trap 'exit_server' SIGINT SIGQUIT SIGTERM
exit_server() {
    echo "Shutdown signal received."
    ./stop.sh
}

SERVER_CONF="$APP_ROOT/Save/serverconfig.xml"
if [ "$FLAG_COPY_CONF" = true ] || [ ! -e "$SERVER_CONF" ] ; then
    echo "Copy and use default serverconfig.xml to Game."
    cp "$HOME/serverconfig-default.xml" "$SERVER_CONF"
fi

echo "Starting 7D2D Server."
"$APP_ROOT/startserver.sh" -configfile="$SERVER_CONF" &

PID=$!
wait $PID
