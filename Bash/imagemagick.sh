
docker run -v /your/images:/imgs dpokidov/imagemagick /imgs/sample.png -resize 100x100 /imgs/resized-sample.png

# Get Image Info
magick identify 1705890706514.jpg

docker run -v ./config:/imgs dpokidov/imagemagick magick identify /imgs/img_1.jpg
docker run --entrypoint=identify -v ./config:/imgs dpokidov/imagemagick /imgs/img.jpg

# Resize Image to Specific Size
convert 1705890706514.jpg -resize 1290x2796! new.jpg
docker run -v ./config:/imgs dpokidov/imagemagick /imgs/img_1.jpg -resize 1290x2796! new.jpg
docker run --entrypoint=identify -v ./config:/imgs dpokidov/imagemagick new.jpg

# Crop Image by Specific Coordinates
convert input_image.jpg -crop widthxheight+x+y output_image.jpg
convert input_image.jpg -crop 100x50+10+20 output_image.jpg
docker run -v ./config:/imgs dpokidov/imagemagick /imgs/img_2.jpg -crop 1290x2960+630+0 new_2.jpg

# Convert Image Format
magick input.webp output.jpg
docker run -v ./config:/imgs dpokidov/imagemagick /imgs/test.webp test.jpg

# Remove Background
convert image.png -background white -alpha remove -alpha off white.png
