#!/bin/sh

destination="/mnt/backup/jason"

# needs root privileges to run
if [ $(id -u) -ne 0 ]; then
  echo Rerunning as root...
  exec sudo "$0" "$@"
  #exit $?
  # echo ERROR: Must be run as root! >&2
  # exit 1
fi

# Proceed with backup only if backum medium is present
if [ -d "$destination" ]; then
  exit_status=

  # System files
  echo Backing up system files...
  [ -d "$destination/system" ] || mkdir "$destination/system"
  duplicity --full-if-older-than 3M --verbosity info --no-encryption / --include /etc --include /var/lib/pacman/local --include /boot --exclude '**' "file://$destination/system"
  exit_status=$?
  if [ $exit_status -eq 0 ]; then
    echo System files backup complete.
  else
    echo System files backup aborted.
  fi

  sync
  
  if [ $exit_status -eq 0 ]; then # Remove old backups
    echo Removing old full system backups...
    duplicity remove-all-but-n-full 2 --force "file://$destination/system"
    echo Removed old full system backups.
  fi

  sync

  # Crontabs
  # crontabs in /etc are already backed up in system backup
  echo Backing up user crontabs...
  [ -d "$destination/crontabs" ] || mkdir "$destination/crontabs"
  duplicity --full-if-older-than 3M --verbosity info --no-encryption / --include /etc --include /var/spool/cron --exclude '**' "file://$destination/crontabs"
  exit_status=$?
  if [ $exit_status -eq 0 ]; then
    echo User crontab backup complete.
  else
    echo User crontab backup aborted.
  fi

  sync
  
  if [ $exit_status -eq 0 ]; then # Remove old backups
    echo Removing old full user crontab backups...
    duplicity remove-all-but-n-full 2 --force "file://$destination/system"
    echo Removed old full user crontab backups.
  fi

  sync

  # User data
  echo Backing up user data...
  [ -d "$destination/data" ] || mkdir "$destination/data"
  duplicity --full-if-older-than 3M --verbosity info --no-encryption / --include /home --include /data --exclude '**' "file://$destination/data"
  exit_status=$?
  if [ $exit_status -eq 0 ]; then
    echo User data backup complete.
  else
    echo User data backup aborted.
  fi

  sync

  if [ $exit_status -eq 0 ]; then # Remove old backups
    echo Removing old full user data backups...
    duplicity remove-all-but-n-full 2 --force "file://$destination/data"
    echo Removed old full user data backups.
  fi

  sync

  echo Backup complete.

else
  echo 'ERROR: Backup medium not found!' >&2;
  exit 2
fi
