#!/bin/bash

growl() {
  message="display notification \"$*\" with title \"VideoTransport\""
  osascript -e "$message"
}

yell() { echo "$0: $*" >&2; }
die() { yell "$*"; growl "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }

upload_to_file_server() {
  growl "Connecting to $FILE_SERVER_HOSTNAME"
  mkdir $MOUNT_POINT
  try mount_afp $FILE_SERVER $MOUNT_POINT
  growl "Uploading $@ to $FILE_SERVER_HOSTNAME"
  try cp -r $1 $MOUNT_POINT
  growl "Upload complete!"
  growl "Disconnecting from $FILE_SERVER_HOSTNAME"
  umount $MOUNT_POINT
}

convert() {
  try ffmpeg -i $@ \
    -c:v libx264 \
    -preset ultrafast \
    -crf 20 \
    -c:a libfdk_aac -vbr 4 -ac 2 \
    -af highpass=f=20,lowpass=f=3000
    -movflags \
    +faststart \
    $@.mp4
}

video_file=$1

if [ ! -f "$video_file" ]; then
  die "USAGE: $0 filename"
fi

try source .env
# upload_to_file_server $video_file
convert $video_file
