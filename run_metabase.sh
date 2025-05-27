#!/bin/bash

echo "✅ MB_JETTY_PORT: $MB_JETTY_PORT"
exec java $JAVA_OPTS -jar /app/metabase.jar
