#!/usr/bin/env bash
set -euo pipefail

echo "🔧 Initializing Metabase Docker Entrypoint..."

if [[ -n "${PORT:-}" ]]; then
  export MB_JETTY_PORT="$PORT"
fi

if [[ -n "${DATABASE_URL:-}" ]]; then
  export MB_DB_CONNECTION_URI="$DATABASE_URL"
fi

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

if [[ -n "${JAVA_TIMEZONE:-}" ]]; then
  JAVA_OPTS+=" -Duser.timezone=$JAVA_TIMEZONE"
fi

echo "🚀 Launching Metabase with JAVA_OPTS: $JAVA_OPTS"

exec /app/run_metabase.sh
