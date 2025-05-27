# Use the official Metabase Enterprise image
FROM metabase/metabase:v0.54.10.x

# Set workdir for clarity
WORKDIR /app

# Copy custom entrypoint script
COPY docker-entrypoint.sh /app/docker-entrypoint.sh

# Ensure entrypoint has correct permissions
RUN chmod +x /app/docker-entrypoint.sh

# Use the custom entrypoint
ENTRYPOINT ["/app/docker-entrypoint.sh"]
