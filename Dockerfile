# Use an official Node.js LTS (Long Term Support) image as the base image
FROM node:16-alpine

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

COPY node_modules ./node_modules

# Install dependencies
RUN npm install -g npm@8.19.4

 

# Copy the rest of the application code to the working directory
COPY . .

# Build TypeScript code (replace `tsc` with your TypeScript compiler command if different)
# Install Nx CLI locally
RUN npm install --save-dev @nrwl/cli

# Reset Nx cache
RUN ./node_modules/.bin/nx reset

RUN npm run build

# Expose the port your app runs on
EXPOSE 3000

# Command to run the application
CMD ["node", "dist/apps/api/main.js"]
