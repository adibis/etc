#!/bin/bash
#TODO
# mount -o bind /dev /media/sda2/dev/
# mount -o bind /sys /media/sda2/sys/
# mount -o bind /proc /media/sda2/proc/
# chroot /media/sda2/
# grub-mkconfig -o /boot/grub/grub.cfg

# Default directory to be backed up
DIR_TO_BACKUP="/home/aditya/Git"
# Default directory to store backps
DESTINATION_DIR="/home/aditya/Backup"

# p = preserve permissions; P = store absolute path; c = create; j = bzip2; f = overwrite; v = verbose
TAR_FLAGS=pcvjf

#Title for the application
BACKTITLE="Archlinux - Config  and Package List Backup Script"

# Backup name
comp="${HOSTNAME}"  # Computer name
dist="arch"         # Distro
date="$(date "+%F")"
bckp_file="$DESTINATION_DIR/$comp-$dist-$date.tar.bz2"

# Main menu -- this is displayed when the program runs.
main_menu(){
# Options
    dialog --backtitle "$BACKTITLE"\
    --title "Main Menu"\
    --nocancel\
    --nook\
    --menu "Please select one of the following" 0 0 0 \
    "System Backup" "Create a new backup"\
    "System Restore" "Restore from a previous backup"\
    "Package List Backup" "Create a list of packages installed on the system"\
    "Package Source Backup" "Backup the sources for locally installed packages"\
    "Install Packages" "Install packages from the backed up list and sources"\
    "Quit" "" 2> /tmp/backup.ans

    case $(cat /tmp/backup.ans) in
    "System Backup")prepare_backup;;
    "System Restore")prepare_restore;;
    "Package List Backup")make_pkg_list;;
    "Package Source Backup")copy_pkg_sources;;
    "Install Packages")install_pkgs;;
    "Quit")rm /tmp/backup.ans;exit;;
    *) main_menu;;
    esac
}

# Find all the bzip2 archives in the backup directory and list them.
# TODO: Multiple backups on same day -- way to select them.
backup_list(){
    files=""
    for i in $DESTINATION_DIR/*.tar.bz2
    do
        files="$files $i Backup "
    done
    dialog --menu "Backup List" 0 0 0 $files 2> /tmp/backup.ans
}

# Asks user for path to the directory they want to backup.
# Default is the root directory.
get_path(){

    text="Enter full path of the directory to backup:"
    dialog --inputbox "$text" 0 50 2> /tmp/backup.ans $DIR_TO_BACKUP

    if [ $? -eq 0 ]; then
        DIR_TO_BACKUP=$(cat /tmp/backup.ans)
    else
        main_menu
    fi
}

# Prepare the backup. Placeholder for now to allow for custom backup names.
# Currently it just gets the directory to backup and proceeds to make archive.
prepare_backup(){

#    default_name="Backup_`date +%F`.tar.gz"
#
#    text="Enter Backup name\nEmpty for current date backup:"
#    dialog --inputbox "$text" 0 0 2> /tmp/backup.ans
#
#    if [ $? -eq 0 ]; then
#        #Check name
#        name=$(cat /tmp/backup.ans)
#        if [ -n "$name" ]; then
#            name="$name.tar.gz"
#        else
#            name=$default_name
#        fi
        get_path
        do_backup
#    else
#        main_menu
#    fi
}

# Prepare the restore. Since the backups always contain full paths,
# we don't ask for the path to restore to.
prepare_restore(){

    backup_list
    rstr_name=$(cat /tmp/backup.ans)

    if [ -n "$rstr_name" ]; then
        if [ -f $rstr_name ]; then
            do_restore
        else
            dialog --msgbox "File $rstr_name not found." 0 0
            main_menu
        fi
    else
        dialog --msgbox "Backup name cannot be empty." 0 0
        main_menu
    fi
}

get_passwd(){

dialog --passwordbox "Please enter your encryption key" 0 50 2> /tmp/backup.ans

if [ $? -eq 0 ]; then
    bckp_passwd=$(cat /tmp/backup.ans)
else
    main_menu
fi

dialog --passwordbox "Please enter the key again" 0 50 2> /tmp/backup.ans

if [ $? -eq 0 ]; then
    confirm_passwd=$(cat /tmp/backup.ans)
else
    main_menu
fi

if [ "$bckp_passwd" != "$confirm_passwd" ]; then
    dialog --msgbox "The keys did not match. Please enter the keys again." 10 50
    get_passwd
else
    #dialog --msgbox "Your Key Is => $bckp_passwd" 10 50
    ""
fi
}

# Do the actual backup archive. This generates a bzip 2 archive.
# TODO - Add an encryption option.
do_backup(){

    if [ -f "$bckp_file" ]; then
        dialog --msgbox "WARNING! FILE EXIST. WILL BE OVERWRITTEN!" 15 50
    fi

    dialog --yesno "Starting Backup $DIR_TO_BACKUP to $bckp_file.\n\nDo you want to continue?" 15 0

    # Check answer yes/no
    # Yes
    if [ $? -eq 0 ]; then
        cd / >/dev/null
        dialog --yesno "Do you want to encrypt your backups?" 15 0
        if [ $? -eq 0 ]; then
            get_passwd
            starttime=`date`
            (tar -pcvf - --one-file-system --exclude=/dev --exclude=/media --exclude=/mnt --exclude=/proc --exclude=/sys $DIR_TO_BACKUP 2>log\
            | pv -n -s `du -sb $DIR_TO_BACKUP | awk '{ print $1 }'` | bzip2 - | openssl enc -aes-256-cbc -e -k "$bckp_passwd" > $bckp_file) 2>&1\
            | dialog --gauge 'Creating Backup, '$DIR_TO_BACKUP' > '$bckp_file'' 10 50
        else
            starttime=`date`
            (tar -pcvf - --one-file-system --exclude=/dev --exclude=/media --exclude=/mnt --exclude=/proc --exclude=/sys $DIR_TO_BACKUP 2>log\
            | pv -n -s `du -sb $DIR_TO_BACKUP | awk '{ print $1 }'` | bzip2 > $bckp_file) 2>&1\
            | dialog --gauge 'Creating Backup, '$DIR_TO_BACKUP' > '$bckp_file'' 10 50
        fi

        dialog --msgbox "BACKUP COMPLETE\n\n$DIR_TO_BACKUP > $bckp_file\n\nstarted on $starttime\ncompleted on `date`\n\nPress Enter to exit." 15 0
        main_menu
    # No
    else
        main_menu
    fi
}

# Do the actual restore. All paths are absolute.
# TODO - Decrypt if needed.
do_restore(){
    dialog --yesno "Starting Restore from $name to $DIR_TO_BACKUP\n\nDo you want to continue?" 15 0

    if [ $? -eq 0 ]; then
        cd / >/dev/null
        starttime="`date`"
        (pv -n $name | tar -xvjpf - -C $DIR_TO_BACKUP ) 2>&1 | dialog --gauge "Extracting file..." 6 50
        mkdir /dev /home /media /mnt /proc /sys

        dialog --msgbox "RESTORE COMPLETE\n\nstarted on $starttime\ncompleted on `date`" 15 0

        main_menu
    else
        main_menu
    fi
}

# Move to the directory where the script is
cd `dirname "$0"`
clear

# Make sure that the user running the script is superuser
# If yes, check if the dialog program is installed
if [ `id -u` == 0 ]; then
    # Check for dialog
    if [ -f /usr/bin/dialog ]; then
        ""
    else
        echo "Please install the dialog program to use this script. Exiting."
        exit
    fi

    main_menu
    rm /tmp/backup.ans

# If not superuser
else
    echo "Please run this script as root."
fi

# (tar -cvf - Git/ 2>log | pv -n -s `du -sb Git | awk '{ print $1 }'` | gzip > out.tgz) 2>&1 | dialog --gauge 'Creating Backup' 10 50
# (pv -n file.tgz | tar xzf - -C target_directory ) 2>&1 | dialog --gauge "Extracting file..." 6 50
