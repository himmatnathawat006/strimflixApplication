# ==========================================
# Stage 1: Build & Source Preparation
# ==========================================
FROM alpine:3.18 AS builder

# Set the working directory
WORKDIR /app

# Copy the build output directory
COPY StreamFlix-build/ .

# Verify the copy was successful
RUN ls -la

# ==========================================
# Stage 2: Serve using Lightweight Nginx
# ==========================================
FROM nginx:1.25.1-alpine

# Copy custom nginx configuration for SPA routing
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Clean default Nginx public directory
RUN rm -rf /usr/share/nginx/html/*

# Copy build files from Stage 1 (builder)
COPY --from=builder /app /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
