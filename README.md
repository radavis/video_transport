# Video Transport


## What does this do?

Backups a QuickTime video from your local machine to a fileserver via scp.


## Automate

Have this script watch a folder and auto upload:

* Automator -> Folder Action
* Choose a folder to watch (ie: `~/Screencasts`)
* Run Shell Script
  - Shell: `/bin/zsh`
  - Pass input: as arguments

```
#!/bin/zsh

/full/path/to/video_transport -u user.name -h hostname -r remote_path --filename $1
```


## Follow what this script is doing locally

```
tail -f /var/log/system.log | grep "video_transport"
```


## To Do

* [ ] Post success/failure state to sinatra app
* [x] Option to enable/disable local growl notifications
* [ ] Check for successful upload (md5, filesize?)
* [ ] Make it so that the order of arguments does not matter
