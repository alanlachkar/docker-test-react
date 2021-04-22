# Build Phase
# Error can occur because of builder name
# If that happens remove "as builder"
FROM node:alpine as builder 

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .

RUN npm run build


# Run Phase
FROM nginx

# Copy /app/build from the build phase into usr/share...
# Error can occur because of builder name
# Write 0 instead of builder
COPY --from=builder /app/build usr/share/nginx/html

# No need to specify a CMD because 
# the actual default CMD of the nginx image is to start nginx

########################################################
## Comands to use in terminal
## docker build . --> build a image with this Dockerfile
## docker run -p 8080:80 <container_id>
## Start web browser with "localhost:8080"
########################################################
