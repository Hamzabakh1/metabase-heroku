# Use the official Metabase OSS image (no ‘.x’ tag)
FROM metabase/metabase:v0.54.10

# Set working directory
WORKDIR /app

# Copy entrypoint and startup scripts
COPY docker-entrypoint.sh /app/docker-entrypoint.sh
COPY run_metabase.sh    /app/run_metabase.sh

# Make scripts executable
RUN chmod +x /app/docker-entrypoint.sh /app/run_metabase.sh

# Entrypoint for all dynos
ENTRYPOINT ["/app/docker-entrypoint.sh"]
