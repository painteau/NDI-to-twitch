INRES="1920x1080" # input resolution
OUTRES="1920x1080" # output resolution
FPS="60" # target FPS
GOP="120" # i-frame interval, should be double of FPS,
GOPMIN="60" # min i-frame interval, should be equal to fps
THREADS="0" # use as many threads as possible
CBR="6000k" # constant bitrate (should be between 1000k - 3000k)
QUALITY="ultrafast"  # one of the many FFMPEG presets
AUDIO_SRATE="48000"
AUDIO_CHANNELS="2" #1 for mono output, 2 for stereo
AUDIO_ERATE="160k" #audio encoding rate
STREAM_KEY="" #your twitch stream key goes here
SERVER="live-mrs" #  https://stream.twitch.tv/ingests/ for list
NDI_INPUT="DESKTOP-168HG7 (PC-2)"

~/ffmpeg-ndi/ffmpeg  -f libndi_newtek -i "$NDI_INPUT" -s "$INRES" -r "$FPS" \
-f flv -ac $AUDIO_CHANNELS -b:a $AUDIO_ERATE -ar $AUDIO_SRATE \
-vcodec libx264 -g $GOP -keyint_min $GOPMIN -b:v $CBR -minrate $CBR \
-maxrate $CBR  -pix_fmt yuv420p -s $OUTRES \
-acodec libmp3lame -threads $THREADS -strict normal \
-bufsize $CBR "rtmp://$SERVER.twitch.tv/app/$STREAM_KEY"
