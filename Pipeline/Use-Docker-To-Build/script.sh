# Git Clone URL
git clone https://github.com/Neix20/my-app.git

# Docker Build Image
docker build -t txe1/gay-img .

############
# Method 1
############

# Run Docker image
docker run -p 3000:5173 --name simple-react-app -d txe1/gay-img

# Test App
curl localhost:3000

# Copy Dist Folder
docker create --name extract-dist txe1/gay-img
docker cp extract-dist:/usr/src/app/dist .
docker rm extract-dist

# Copy Dist Folder 2
docker cp <container-name>:/usr/src/app/dist .

docker cp txe1/gay-img:/usr/src/app/dist .

############
# Method 2
############

# This methods doesn't work :'(

docker run -p 3000:5173 --name simple-react-app -v $(pwd)/output:/usr/src/app/dist -d txe1/gay-img
docker run --rm -v ./output:/usr/src/app/dist -d txe1/gay-img

