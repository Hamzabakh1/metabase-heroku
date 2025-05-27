# Use the official Metabase OSS image
FROM metabase/metabase:v0.54.10

WORKDIR /app

# Copy our unified startup script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Heroku will run this as the web process
CMD ["/app/start.sh"]
