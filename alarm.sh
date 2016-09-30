#!/bin/sh

MEDIA_PLAYER=vlc
# DISPLAY for cron
DISPLAY=${DISPLAY:-$(cat "$HOME/.DISPLAY")}
ALARM_PLAYLIST=${ALARM_PLAYLIST:-"$HOME/Music/Playlists/alarm.m3u"}
GRAPHICAL=1
AUDIO_LEVELS_ADJUSTED=1

show_help() {
cat <<EOF
Usage: ${0##*/} [OPTIONS] 
Starts a media player with a predefined playlist, optionally adjusting volume levels.

OPTIONS
EOF
grep '###' "$0" | grep -v 'grep' | sed 's/^\s*###/   /'
}

# command line options
OPTIND=1
while getopts aeEf:hknp: opt; do
  case $opt in
    ### -p player
    ###    Selects the player to play the alarm with. Legal values are
    ###    audacious, cvlc, nvlc, mplayer, vlc. Defaults to vlc.
    p)
      MEDIA_PLAYER="$OPTARG"
      ;;
    ### -n
    ###    Don't use GUI when possible
    n)
      GRAPHICAL=0
      DISPLAY=
      ;;
    ### -k
    ###    DEPRECATED
    ###    Kill all PulseAudio instances first and restart it
    k)
      killall pulseaudio
      sleep 3
      DISPLAY=$DISPLAY pulseaudio --start
      sleep 1
      ;;
    ### -a
    ###    Adjust volume levels. Levels are restored after the alarm is closed.
    ### -e
    ###    Adjust headphone volume. Implies -a.
    ### -E
    ###    Like -e, but makes the headphone levels safer for actual headphones.
    a|e|E)
      # save only if not already adjusted
      if [ $AUDIO_LEVELS_ADJUSTED -ne 0 ]; then
        master_volume="$(amixer get Master | tail -1 | head -1)"
        master_mute="$(echo "$master_volume" | awk '{print $3}' | sed 's/\[\|\]//g')"
        master_volume="$(echo "$master_volume" | awk '{print $4}' | sed 's/\[\|\]//g')"
        
        speaker_volume="$(amixer get Speaker | tail -2 | head -1)"
        speaker_mute="$(echo "$speaker_volume" | awk '{print $7}' | sed 's/\[\|\]//g')"
        speaker_volume="$(echo "$speaker_volume" | awk '{print $5}' | sed 's/\[\|\]//g')"
        
        headphone_volume="$(amixer get Headphone | tail -2 | head -1)"
        headphone_mute="$(echo "$headphone_volume" | awk '{print $7}' | sed 's/\[\|\]//g')"
        headphone_volume="$(echo "$headphone_volume" | awk '{print $5}' | sed 's/\[\|\]//g')"
      fi

      amixer -q set Master 100
      amixer -q set Master on
      amixer -q set Speaker 75
      amixer -q set Speaker on

      if [ $opt = e ]; then
        amixer -q set Headphone 48
        amixer -q set Headphone on
      elif [ $opt = E ]; then
        amixer -q set Headphone 39
        amixer -q set Headphone on
      fi

      AUDIO_LEVELS_ADJUSTED=0
      ;;
    ### -f file
    ###    Specifies the file to play. Overrides the ALARM_PLAYLIST variable.
    ###    Defaults to $HOME/Music/Playlists/alarm.m3u
    f)
      ALARM_PLAYLIST="$OPTARG"
      ;;
    ### -h
    ###    Show this help text.
    h)
      show_help
      exit
      ;;
  esac
done


# shift remaining arguments to pass to program
shift $((OPTIND - 1))


# Play alarm playlist

case $MEDIA_PLAYER in
  audacious)
    # set volume to 100%
    ( sleep 5; audtool --set-volume 100 ) &
    # turn on shuffle if not already enabled
    ( sleep 5; [ "$(audtool --playlist-shuffle-status)" = "off" ] && audtool --playlist-shuffle-toggle ) &
    # turn on repeat if not already enabled
    ( sleep 5; [ "$(audtool --playlist-repeat-status)"  = "off" ] && audtool --playlist-repeat-toggle ) &
    DISPLAY=$DISPLAY /usr/bin/audacious $ALARM_PLAYLIST "$@"
    ;;
  cvlc)
    if [ $GRAPHICAL -eq 1 ]; then
      xterm -display $DISPLAY -e /usr/bin/vlc -I rc --loop --random "$ALARM_PLAYLIST" "$@"
    else
      /usr/bin/cvlc --loop --random "$ALARM_PLAYLIST" "$@"
    fi
    ;;
  nvlc)
    if [ $GRAPHICAL -eq 1 ]; then
      xterm -display $DISPLAY -e /usr/bin/vlc -I ncurses --loop --random "$ALARM_PLAYLIST" "$@"
    else
      /usr/bin/nvlc --loop --random "$ALARM_PLAYLIST" "$@"
    fi
    ;;
  mplayer)
    if [ $GRAPHICAL -eq 1 ]; then
      xterm -display $DISPLAY -e /usr/bin/mplayer -playlist -shuffle "$ALARM_PLAYLIST" "$@"
    else
      /usr/bin/mplayer -playlist -shuffle "$ALARM_PLAYLIST" "$@"
    fi
    ;;
  *)
    DISPLAY=$DISPLAY /usr/bin/vlc --loop --random "$ALARM_PLAYLIST" "$@"
    ;;
esac
EXIT_VALUE=$?

# restore audio levels if adjusted
if [ $AUDIO_LEVELS_ADJUSTED -eq 0 ]; then
  amixer -q set Master $master_volume
  amixer -q set Master $master_mute
  amixer -q set Speaker $speaker_volume
  amixer -q set Speaker $speaker_mute
  amixer -q set Headphone $headphone_volume
  amixer -q set Headphone $headphone_mute
fi

exit $EXIT_VALUE
