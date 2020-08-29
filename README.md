Scripts
=======
Some personal scripts that I use. Many are not intended to be used
as-is; instead, use them as a base to create your own personalized
scripts. These scripts have only been tested on Linux, but some will
probably work on other systems, perhaps with small modifications.

All scripts are released under the [MIT license][].

[MIT license]: https://opensource.org/licenses/MIT

alarm.sh
--------
A wakeup alarm script. It adjusts volume levels and plays a playlist.
Pass in `-h` for more details.

alarm-set
---------
Sets up a one-time alarm. It depends on `alarm.sh` and [`atd`][at]. By
default, the `-e` flag is passed to `alarm.sh` to manipulate the volume.
Pass in `-E` to make it safer for headphones. There is currently no way
to disable volume manipulation.

The rest of the arguments are passed to `at`.

[at]: https://en.wikipedia.org/wiki/At_%28Unix%29

backlight-off
-------------
Turns off the display backlight.

backup.sh
---------
My backup script, using [Duplicity][] as its backend. You will probably
want to change the paths defined in the script.

[Duplicity]: http://www.nongnu.org/duplicity/

breathe
-------
`breathe` allows a job to repeatedly run for a length of time then rest
for a length of time by sending the `CONT` and `STOP` signals to the
process after the specified durations. The durations are passed to
`sleep`.

    breathe <on_duration> <off_duration> <command>

catls
-----
Outputs the contents of the given paths. If the path is a directory, an
`ls` will be performed on it. Otherwise, a `cat` will be performed.
Multiple paths may be passed and each will be processed independently.

This is especially useful when browsing an unfamiliar place like
[`/proc`][proc].

[proc]: http://www.tldp.org/LDP/Linux-Filesystem-Hierarchy/html/proc.html

(dis)connect-external-monitor, toggle-external-monitor
------------------------------------------------------
Connects/disconnects an external monitor and configures [LXPanel][] for
the dual-monitor setup. `toggle-external monitor` toggles the display on
and off depending on its current state; it depends on
(`dis`)`connect-external-monitor`

[LXPanel]: http://wiki.lxde.org/en/LXPanel

ffmpeg-gif
----------
Converts an FFmpeg-compatible file to an animated GIF. Based on a script
from [phk.me][]

[phk.me]: http://blog.pkh.me/p/21-high-quality-gif-with-ffmpeg.html

ls-swap
-------
Lists the approximate swap usage of each process and sorts them by usage
in ascending order.

mkscript
--------
Creates a file from the contents of stdin and makes it executable.
Useful for quickly making scripts.

npm-scripts
-----------
Outputs the `scripts` section of a `package.json`. Can be run from anywhere
inside a project that has a `package.json`. Requires [`jq`][jq].

[jq]: https://stedolan.github.io/jq/

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

redshift-suspend
----------------
Resets redshift to 6500K while the given program is running, then
returns redshift to the temperature it was previously at. If invoked
multiple times, it will return the temperature only after all programs
have exited.
Depends on [redshift-adjust][].

[redshift-adjust]: https://github.com/maandree/redshift-adjust

remote-size
-----------
Returns the size of the given URI. The size is determined by the
`Content-Length` HTTP header. Pass `-h` to output in a "human-readable"
format.

remove-trailing-silence
-----------------------
Trims trailing silence from an audio file. Pass the audio file as the
first parameter and the output filename as the second. Depends on [ffmpeg][].

[ffmpeg]: https://ffmpeg.org/

screenshot, screenshot-window
-----------------------------
`screenshot` takes a screenshot of the given window, or the whole
display (the root window) if no window given. It depends on
[ImageMagick][].

[ImageMagick]: https://www.imagemagick.org/

`screenshot-window` takes a screenshot of the currently-focused window.
It will pass its arguments to `screenshot`.  It depends on `screenshot`
and [`xdotool`][xdotool].

[xdotool]: http://www.semicomplete.com/projects/xdotool/

toggle-screensaver
------------------
`toggle-screensaver` disables or enables your screensaver (set to
[xscreensaver][] in the script) by sending SIGSTOP or SIGCONT to the process.
It will also display a desktop notification via `notify-send`.

[xscreensaver]: https://www.jwz.org/xscreensaver/

torsh
-----
A [Tor][] wrapper around bash. No history is saved. Tor mode can be
detected by checking the `TORSH` environment variable.

[Tor]: https://www.torproject.org/

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
