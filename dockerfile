# -------- DEVELOPMENT --------
    FROM node:18-alpine AS development

    WORKDIR /app
    
    COPY package*.json ./
    RUN npm install
    
    COPY . .
    
    ARG VITE_API_URL
    ENV VITE_API_URL=$VITE_API_URL
    
    EXPOSE 5173
    CMD ["npm", "run", "dev"]
    
    # -------- BUILD --------
    FROM node:18-alpine AS builder
    
    WORKDIR /app
    COPY --from=development /app .
    
    ARG VITE_API_URL
    ENV VITE_API_URL=$VITE_API_URL
    
    RUN npm run build
    
    # -------- PRODUCTION --------
    FROM nginx:alpine AS production
    
    COPY --from=builder /app/dist /usr/share/nginx/html
    
    # NGINX config for SPA routing
    COPY nginx.conf /etc/nginx/conf.d/default.conf
    
    EXPOSE 80
    CMD ["nginx", "-g", "daemon off;"]
    


