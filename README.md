# Video Transport

A set of scripts to automate the process of moving Screencasts around.


## Dependencies

* ffmpeg - `brew install ffmpeg`
* [python](http://radavis.github.io/2015/05/20/python-development-on-osx.html)
* [py_video_sync](https://github.com/radavis/py_video_sync)


## "Three-Fingered Claw" technique of scripting

[source](http://stackoverflow.com/a/25515370)

```
yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }
```
