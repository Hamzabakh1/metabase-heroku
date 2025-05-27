#!/bin/bash
# Quick sanity-check of port
echo "✅ Starting Metabase on port $MB_JETTY_PORT"
exec java $JAVA_OPTS -jar /app/metabase.jar
