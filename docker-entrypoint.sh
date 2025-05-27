#!/usr/bin/env bash
set -euo pipefail

echo "🔧 Initializing Metabase Entrypoint..."

# 1) Bind to Heroku-assigned PORT
if [[ -n "${PORT:-}" ]]; then
  export MB_JETTY_PORT="$PORT"
  echo "📡 MB_JETTY_PORT set to $MB_JETTY_PORT"
fi

# 2) Point Metabase at Heroku Postgres
if [[ -n "${DATABASE_URL:-}" ]]; then
  export MB_DB_CONNECTION_URI="$DATABASE_URL"
  echo "🔗 MB_DB_CONNECTION_URI set from DATABASE_URL"
fi

# 3) JVM tuning for container environments
JAVA_OPTS+=" -XX:+UnlockExperimentalVMOptions"
JAVA_OPTS+=" -XX:+UseContainerSupport"
JAVA_OPTS+=" -XX:-UseGCOverheadLimit"
JAVA_OPTS+=" -XX:+UseCompressedOops"
JAVA_OPTS+=" -XX:+UseCompressedClassPointers"
JAVA_OPTS+=" -Xverify:none"
JAVA_OPTS+=" -XX:+UseG1GC"
JAVA_OPTS+=" -XX:+UseStringDeduplication"
JAVA_OPTS+=" -server"
JAVA_OPTS+=" -Djava.awt.headless=true"
JAVA_OPTS+=" -Dfile.encoding=UTF-8"

# 4) **Limit maximum heap to 300 MB** to avoid OOM kills on a 512 MB dyno
JAVA_OPTS+=" -Xmx300m"  
# 5) Also limit heap as a percentage of container RAM
JAVA_OPTS+=" -XX:MaxRAMPercentage=75.0"

# 6) (Optional) Explicit site URL to avoid host‐validation loops
if [[ -n "${MB_SITE_URL:-}" ]]; then
  echo "🌐 MB_SITE_URL is $MB_SITE_URL"
fi

echo "🚀 Launching Metabase with JAVA_OPTS: $JAVA_OPTS"
exec /app/run_metabase.sh
