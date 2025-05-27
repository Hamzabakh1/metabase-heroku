#!/usr/bin/env bash
set -euo pipefail

echo "🔧 Init Metabase on Heroku…"

# 1) Bind Jetty to the dyno’s PORT
if [[ -n "${PORT:-}" ]]; then
  export MB_JETTY_PORT="$PORT"
  echo "📡 MB_JETTY_PORT=$MB_JETTY_PORT"
fi

# 2) Use DATABASE_URL for metadata storage
if [[ -n "${DATABASE_URL:-}" ]]; then
  export MB_DB_CONNECTION_URI="$DATABASE_URL"
  echo "🔗 MB_DB_CONNECTION_URI from DATABASE_URL"
fi

# 3) Help Metabase know its public URL (avoids host-validation loops)
if [[ -n "${MB_SITE_URL:-}" ]]; then
  echo "🌐 MB_SITE_URL=$MB_SITE_URL"
fi

# 4) JVM tuning for containers & strict heap cap
JAVA_OPTS=(
  -XX:+UseContainerSupport       # Java 9+ container awareness
  -XX:+UnlockExperimentalVMOptions
  -XX:-UseGCOverheadLimit
  -XX:+UseG1GC
  -XX:+UseStringDeduplication
  -Djava.awt.headless=true
  -Dfile.encoding=UTF-8
  -Xmx256m                       # Limit heap to 256 MB (free dyno = 512 MB total)
  -XX:MaxRAMPercentage=50.0      # Or “use at most 50% of detected RAM” 
)

echo "🚀 Launching Metabase with: ${JAVA_OPTS[*]}"
exec java "${JAVA_OPTS[@]}" -jar /app/metabase.jar
