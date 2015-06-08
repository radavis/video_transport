# Video Transport

A set of scripts to automate the process of moving Screencasts around.


## What does this do?

* Backups a QuickTime video to a fileserver specified by the environment.
* Processes the QuickTime video to a format that Vimeo is happy with.
  - mp4 format
  - Letterboxed 720p
  - Audio filtering (pass 20Hz-5kHz)
* Uploads the processed video to Vimeo.


## Dependencies

* ffmpeg - `brew install ffmpeg`
* [python](http://radavis.github.io/2015/05/20/python-development-on-osx.html)
* [py_video_sync](https://github.com/radavis/py_video_sync)


## Have this script watch a folder:

* Automator -> Folder Action
* Choose a folder to watch (ie: `~/screencasts`)
* Run Shell Script
  - Shell: `/bin/zsh`
  - Pass input: as arguments

```
#!/bin/zsh

/full/path/to/video_transport $1
```


## Follow what this script is doing

```
tail -f /var/log/system.log | grep "video_transport"
```


## "Three-Fingered Claw" technique of scripting

[source](http://stackoverflow.com/a/25515370)

```
yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }
```


## Letterboxing in ffmpeg

[source](http://kevinlocke.name/bits/2012/08/25/letterboxing-with-ffmpeg-avconv-for-mobile/)

```
scale=iw*min($MAX_WIDTH/iw\,$MAX_HEIGHT/ih):ih*min($MAX_WIDTH/iw\,$MAX_HEIGHT/ih)

pad=$MAX_WIDTH:$MAX_HEIGHT:(ow-iw)/2:(oh-ih)/2
```


## To Do

* [x] logging
* [x] include Automator instructions
* [x] move processed video to temporary location
* [ ] delete processed video once uploaded
* [ ] slack integration
