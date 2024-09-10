
# Format
docker run -v $(pwd)/config:/config -it <docker-name> <ffmpeg-cmd> /config/<output-location>
docker run -v $(pwd)/config:/config -it linuxserver/ffmpeg /config/<output-location>

# Split Video Into Frames
ffmpeg -ss 00:00:00 -t 00:30:00 -i trans.mp4 -r 1 image%d.png
docker run -v $(pwd)/config:/config -it linuxserver/ffmpeg -i /config/sampleVideo.mp4 -ss 00:00:00 -t 00:30:00 -r 1 /config/img/image%d.png

# Combine Frame Into Video
ffmpeg -i img\\image%d.jpg -framerate 5 -y  -c:v h264 -r 30 -pix_fmt yuv420p output.mp4
docker run -v $(pwd)/config:/config -it linuxserver/ffmpeg -i /config/img/image%d.png -framerate 5 -y  -c:v h264 -r 30 -pix_fmt yuv420p /config/output.mp4

# Extract Audio
ffmpeg -i sampleVideo.mp4 -q:a 0 -map a output_audio.mp3
docker run -v $(pwd)/config:/config -it linuxserver/ffmpeg -i /config/sampleVideo.mp4 -q:a 0 -map a /config/output_audio.mp3

# Crop Video To Timestamp (E.g. 10 Seconds)
ffmpeg -i sampleVideo.mp4 -ss 00:00:00 -t 00:00:10 -c copy shortVideo.mp4
docker run -v $(pwd)/config:/config -it linuxserver/ffmpeg -i /config/sampleVideo.mp4 -ss 00:00:00 -t 00:00:10 -c copy  /config/shortVideo.mp4

# Crop Audio To Timestamp (E.g. 10 Seconds)
ffmpeg -i sampleAudio.mp3 -ss 00:00:00 -t 00:00:10 -c copy shortAudio.mp3
docker run -v $(pwd)/config:/config -it linuxserver/ffmpeg -i /config/sampleAudio.mp3 -ss 00:00:00 -t 00:00:10 -c copy  /config/shortAudio.mp3

