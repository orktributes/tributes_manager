#!/bin/bash

# -------------------- no_audio ------------------------------------------------------------
ffmpeg -i ./record/*.mkv -c copy -an ./record/no_audio.mp4
ffmpeg -sseof -20 -i ./record/no_audio.mp4 ./record/no_audio_trim.mp4

mkdir ./edited/no_audio

mv ./record/no_audio.mp4 ./edited/no_audio/$(basename $(pwd))_no_audio.mp4
mv ./record/no_audio_trim.mp4 ./edited/no_audio/$(basename $(pwd))_no_audio_trim.mp4

# -------------------- no_audio ------------------------------------------------------------

# -------------------- audio ---------------------------------------------------------------
# ffmpeg -i ./record/*.mkv -codec copy ./record/audio.mp4
# ffmpeg -sseof -60 -i ./record/audio.mp4 ./record/audio_trim.mp4
#
# mkdir ./edited/audio
#
# mv ./record/audio.mp4 ./edited/audio/$(basename $(pwd))_audio.mp4
# mv ./record/audio_trim.mp4 ./edited/audio/$(basename $(pwd))_audio_trim.mp4
# -------------------- audio ----------------------------------------------------------------
