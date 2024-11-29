# Dockerfile for Redis based on Alpine
FROM alpine:3.14

# Install Redis
RUN apk update && apk add --no-cache redis

# Copy Redis configuration file
COPY ./conf/redis.conf /etc/redis/redis.conf

# Expose the Redis port
EXPOSE 6379

# Start Redis server with the custom configuration
CMD ["redis-server", "/etc/redis/redis.conf"]

