#!/bin/bash

set +v
title="create_logkillers.sh"
echo -e '\033]2; '$title'\007'
cd ..
scp=$(pwd)
echo $scp

PS3='Are there existing logkillers?'
options=("Yes" "No")
select opt in "${options[@]}"
do
    case $opt in 
        "Yes")
        echo "Deleting existing logkillers..."
        # seek and destroy
        cd "..\servers"
        find . -name "_scp_logkiller.sh" -type f -delete
        find . -name "_ma_logkiller.sh" -type f -delete
        cd $scp
        find . -name "_scp_logkiller.sh" -type f -delete
        find . -name "_ma_logkiller.sh" -type f -delete
        cd "./home/.config/SCP Secret Laboratory"
        find . -name "_round_logkiller.sh" -type f -delete
        find . -name "_at_logkiller.sh" -type f -delete
        break
        ;;
        "No")
        echo "Skipping logkiller deletion"
        break
        ;;
        *) echo "Invalid option $REPLY";;
    esac
done
clear
PS3='Create SCP logfile killers?'
options=("Yes" "No")
select opt in "${options[@]}"
do
    case $opt in
        "Yes")
        cd $scp
        echo "Creating SCP logkiller..."
        # get user input
        echo "Type in the number of days you want to keep the logs for, followed by [ENTER]:"
        read days
        # seek and destroy
        if [ -d $scp/servers ]; then
            cd $scp/servers
            find . -type d -exec echo "find . -mtime +$days -name '*_SCP_output_log.txt' -type f -delete" > _scp_logkiller.sh {} \;
            echo "SCP logkiller created successfully\!"
        elif [ -d $scp/logs ]; then
            cd $scp/logs
            echo "find . -mtime +$days -name '*_SCP_output_log.txt' -type f -delete" > _scp_logkiller.sh
            echo "SCP logkiller created successfully\!"
        else
            echo "File is in wrong directory\!"
        fi
        break
        ;;
        "No")
        echo "Skipping SCP logkiller creation..."
        break
        ;;
    esac
done
clear
PS3='Create MA logfile killers?'
options=("Yes" "No")
select opt in "${options[@]}"
do
    case $opt in
        "Yes")
        cd $scp
        echo "Creating MA logkiller..."
        # get user input
        echo "Type in the number of days you want to keep the logs for, followed by [ENTER]:"
        read days
        # seek and destroy
        if [ -d $scp/servers ]; then
            cd $scp/servers
            find . -type d -exec echo "find . -mtime +$days -name '*_MA_output_log.txt' -type f -delete" > _ma_logkiller.sh {} \;
            echo "MA logkiller created successfully\!"
        elif [ -d $scp/logs ]
            cd $scp/logs
            echo "find . -mtime +$days -name '*_MA_output_log.txt' -type f -delete" > _ma_logkiller.sh
            echo "MA logkiller created successfully\!"
        else
            echo "File is in wrong directory\!"
        fi
        break
        ;;
        "No")
        echo "Skipping MA logkiller creation..."
        break
        ;;
    esac
done
clear
PS3='Create Round logfile killers?'
options=("Yes" "No")
select opt in "${options[@]}"
do
    case $opt in
        "Yes")
        cd "~/.config/SCP Secret Laboratory"
        # get user input
        echo "Type in the number of days you want to keep the logs for, followed by [ENTER]:"
        read days
        # seek and destroy
        if [ -d ServerLogs ]; then
            find . -type d -exec echo "find . -mtime +$days -name '*.txt' -type f -delete" > _round_logkiller.sh {} \;
            echo "Round logkiller created successfully\!"
        else
            echo "ServerLogs folder not found\!"
        fi
        break
        ;;
        "No")
        echo "Skipping Round logkiller creation..."
        break
        ;;
    esac
done
clear
PS3='Is AdminToolBox installed with logfile creation?'
options=("Yes" "No")
select opt in "${options[@]}"
do
    case $opt in
        "Yes")
        PS3='Create AdminToolBox logfile killers?'
        options=("Yes" "No")
        select opt in "${options[@]}"
        do
            case $opt in
                "Yes")
                cd "~/.config/SCP Secret Laboratory"
                # get user input
                echo "Type in the number of days you want to keep the logs for, followed by [ENTER]:"
                read days
                # seek and destroy
                if [ -d ATServerLogs ]; then
                    find . -type d -exec echo "find . -mtime +$dats -name '*.txt' -type f -delete" > _at_logkiller.sh {} \;
                    echo "AdminToolBox logkiller successfully created\."
                else
                    echo "Can\'t find ATServerLogs"
                fi
                break
                ;;
                "No")
                echo "Skipping AdminToolBox logfile creation..."
                break
                ;;
            esac
        done
        break
        ;;
        "No")
        echo "AdminToolBox feature skipped..."
        break
        ;;
    esac
done

exit 0