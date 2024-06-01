# We are naming this phase as builder phase
# cuz 2 phases - build and run phase for production version
FROM node:16-alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# As we use FROM again, previous block(phase) is 
# assumed as terminated or ended
FROM nginx
# for elasticbeanstalk port mapping
EXPOSE 80
# COPY - refer from dockerhub-nginx docs
COPY --from=builder /app/build /usr/share/nginx/html