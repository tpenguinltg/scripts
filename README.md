Scripts
=======
Some personal scripts that I use. Most are not intended to be used
as-is; instead, use them as a base to create your own personalized
scripts.

All scripts are released under the [MIT license][].

[MIT license]: https://opensource.org/licenses/MIT

alarm.sh
--------
A wakeup alarm script. It adjusts volume levels and plays a playlist.
Pass in `-h` for more details.

backlight-off
-------------
Turns off the display backlight.

backup.sh
---------
My backup script, using [Duplicity][] as its backend. You will probably
want to change the paths defined in the script.

[Duplicity]: http://www.nongnu.org/duplicity/

(dis)connect-external-monitor
-----------------------------
Connects/disconnects an external monitor and configures [LXPanel][] for
the dual-monitor setup.

[LXPanel]: http://wiki.lxde.org/en/LXPanel

ffmpeg-gif
----------
Converts an FFmpeg-compatible file to an animated GIF. Based on a script
from [phk.me][]

[phk.me]: http://blog.pkh.me/p/21-high-quality-gif-with-ffmpeg.html

pause
-----
Emulates the cmd.exe [PAUSE][] command.

[PAUSE]: http://ss64.com/nt/pause.html

pulsewrap
---------
A utility to start [PulseAudio][] specifically for a program (i.e.
Skype). [apulse][] is a better solution, but it doesn't seem to play
well with my current configuration.

[PulseAudio]: https://wiki.freedesktop.org/www/Software/PulseAudio/
[apulse]: https://github.com/i-rinat/apulse

remove-trailing-silence
-----------------------
Trims trailing silence from an audio file. Pass the audio file as the
first parameter and the output filename as the second.

screenshot, screenshot-window
-----------------------------
`screenshot` takes a screenshot of the given window, or the whole
display (the root window) if no window given.

`screenshot-window` takes a screenshot of the currently-focused window.
It will pass its arguments to `screenshot`.  It depends on `screenshot`
and [`xdotool`][xdotool].

[xdotool]: http://www.semicomplete.com/projects/xdotool/

ssh
---
A wrapper around `ssh` to change [Konsole][]'s color scheme while logged
in to a remote server. Assumes the "Linux" color scheme is the default
scheme and changes to "Solarized" while running.

[Konsole]: https://konsole.kde.org/

update-grub
-----------
Updates the GRUB boot file and replaces the first entry's kernel to the
one specified in the script. If `/boot/grub` is under git control, it
also commits before and after the update. This was written because
`linux-lts` was getting picked up first instead of `linux-ck` and I
wanted `linux-ck` to be the default.

weather
-------
Shows the weather according to [wttr.in][]. Takes in the resource name as an
optional parameter (e.g. for wttr.in/Moon, execute `weather Moon`).

[wttr.in]: https://github.com/chubin/wttr.in

xwrap
-----
Executes its arguments in xterm if not in a terminal. xterm will exit
when the program exits.
