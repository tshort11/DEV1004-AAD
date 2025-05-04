# Dockerfile.dev
FROM node:18

# Set working directory
WORKDIR /app

# Copy dependency files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Expose port (default for Vite)
EXPOSE 5173

# Start development server
CMD ["npm", "run", "dev"]
