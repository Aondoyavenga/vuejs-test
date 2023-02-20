# Start with a base image that has Node.js installed
FROM node:14 as builder

# Set the working directory to /app
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Build the Vue.js application for production
RUN npm run build

# Use Nginx as the web server
FROM nginx:1.21-alpine

# Copy the built Vue.js application to the Nginx container
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80 for the web server
EXPOSE 80

# Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]
