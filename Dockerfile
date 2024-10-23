# Use an official Node.js runtime as a parent image
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json first to leverage Docker's layer caching
COPY package*.json ./

# Install dependencies (this includes 'serve' from package.json)
RUN npm install

# Copy the rest of your application code
COPY . .

# Expose port 3000 (default for serve)
EXPOSE 3000

# Run 'serve' using npx, serving the static files on port 3000
CMD npx serve . -l 3000