#!/usr/bin/env bash

# Bind to Heroku dynamic port
if [ "$PORT" ]; then
    export MB_JETTY_PORT="$PORT"
fi

# Use DATABASE_URL if provided
if [ "$DATABASE_URL" ]; then
    export MB_DB_CONNECTION_URI="$DATABASE_URL"
fi

# Java memory optimizations for Heroku
JAVA_OPTS="$JAVA_OPTS -XX:+UnlockExperimentalVMOptions"
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

# Optional timezone
if [ "$JAVA_TIMEZONE" ]; then
    echo "  -> Timezone setting detected: $JAVA_TIMEZONE"
    JAVA_OPTS+=" -Duser.timezone=$JAVA_TIMEZONE"
fi

echo "JAVA_OPTS: $JAVA_OPTS"
export JAVA_OPTS

# Start Metabase
exec /app/run_metabase.sh
