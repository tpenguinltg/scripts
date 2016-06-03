Scripts
=======
Some personal scripts that I use. Most are not intended to be used as-is; instead, use them as a base to create your own personalized scripts.

All scripts are released under the [MIT license](https://opensource.org/licenses/MIT).

alarm.sh
--------
A wakeup alarm script. It adjusts volume levels and plays a playlist. Pass in `-h` for more details.

backup.sh
---------
My backup script, using [Duplicity](http://www.nongnu.org/duplicity/) as its backend. You will probably want to change the paths defined in the script.

(dis)connect-external-monitor
-----------------------------
Connects/disconnects an external monitor and configures [LXPanel](http://wiki.lxde.org/en/LXPanel) for the dual-monitor setup.

ffmpeg-gif
----------
Converts an FFmpeg-compatible file to an animated GIF. Based on a script from [phk.me](http://blog.pkh.me/p/21-high-quality-gif-with-ffmpeg.html)

pause
-----
Emulates the cmd.exe [PAUSE](http://ss64.com/nt/pause.html) command.

pulsewrap
---------
A utility to start [PulseAudio](https://wiki.freedesktop.org/www/Software/PulseAudio/) specifically for a program (i.e. Skype). [apulse](https://github.com/i-rinat/apulse) is a better solution, but it doesn't seem to play well with my current configuration.

remove-trailing-silence
-----------------------
Trims trailing silence from an audio file. Pass the audio file as the first parameter and the output filename as the second.

ssh
---
A wrapper around `ssh` to change [Konsole](https://konsole.kde.org/)'s color scheme while logged in to a remote server. Assumes the "Linux" color scheme is the default scheme and changes to "Solarized" while running.

update-grub
-----------
Updates the GRUB boot file and replaces the first entry's kernel to the one specified in the script. If /boot/grub is under git control, it also commits before and after the update. This was written because `linux-lts` was getting picked up first instead of `linux-ck` and I wanted `linux-ck` to be the default.

weather
-------
Shows the weather according to wttr.in. Takes in the resource name as an optional parameter (e.g. for wttr.in/Moon, execute `weather Moon`).
