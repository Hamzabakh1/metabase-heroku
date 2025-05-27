# Use the official Metabase image
FROM metabase/metabase:v0.54.10

# Set working directory
WORKDIR /app

# Copy scripts
COPY docker-entrypoint.sh /app/docker-entrypoint.sh
COPY run_metabase.sh /app/run_metabase.sh

# Make them executable
RUN chmod +x /app/docker-entrypoint.sh /app/run_metabase.sh

# Set the entrypoint
ENTRYPOINT ["/app/docker-entrypoint.sh"]
