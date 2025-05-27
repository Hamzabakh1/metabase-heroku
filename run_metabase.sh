#!/bin/bash
# Sanity‐check port binding
echo "✅ Starting Metabase on port $MB_JETTY_PORT"
exec java $JAVA_OPTS -jar /app/metabase.jar
