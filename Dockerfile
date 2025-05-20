# Use the official Metabase image
FROM metabase/metabase:latest

# Set working directory (optional, helpful if extending later)
WORKDIR /app

# Heroku dynamically assigns a port; Metabase must listen on it
# Heroku sets $PORT at runtime — no need to hardcode
EXPOSE 3000

# No need for ENTRYPOINT or CMD; official image starts Metabase automatically
