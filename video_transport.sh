#!/bin/bash

growl() {
  message="display notification \"$*\" with title \"VideoTransport\""
  osascript -e "$message"
}

yell() { echo "$0: $*" >&2; }
die() { yell "$*"; growl "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }

upload_to_file_server() {
  mkdir $MOUNT_POINT
  try mount_afp $FILE_SERVER $MOUNT_POINT
  growl "Uploading $@ to $FILE_SERVER_HOSTNAME"
  try cp -r $1 $MOUNT_POINT
  growl "Upload complete!"
  umount $MOUNT_POINT
}

convert() {
  try ffmpeg --version
  video_file=$1
  output_file="${video_file%.*}.mp4"
  growl "Starting conversion of $video_file"
  try ffmpeg -i "$video_file" \
    -vf "scale=iw*sar*min($WIDTH/(iw*sar)\,$HEIGHT/ih):ih*min($WIDTH/(iw*sar)\,$HEIGHT/ih),pad=$WIDTH:$HEIGHT:(ow-iw)/2:(oh-ih)/2" \
    -c:v libx264 \
    -preset ultrafast \
    -crf 20 \
    -c:a aac -strict experimental \
    -af highpass=f=20,lowpass=f=5000 \
    -movflags \
    +faststart \
    $output_file
  growl "Finished conversion \noutput: $output_file"
  echo "$output_file"
}

video_file=$1

if [ ! -f "$video_file" ]; then
  die "USAGE: $0 filename"
fi

try source .env
upload_to_file_server $video_file
converted_file=$(convert $video_file)
title=$(basename $1 .mov)
try python ../py_video_sync/vimeo_uploader.py $video_file $title
