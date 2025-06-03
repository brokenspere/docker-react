# Use a multi-stage build to create a production image with Nginx
# build the React app in the first stage
FROM node:lts-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# copy the build folder output from the builder stage to the nginx html directory
COPY --from=builder /app/build /usr/share/nginx/html