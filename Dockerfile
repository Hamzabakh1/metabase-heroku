FROM metabase/metabase:v0.54.10

WORKDIR /app

COPY docker-entrypoint.sh /app/docker-entrypoint.sh
COPY run_metabase.sh /app/run_metabase.sh

RUN chmod +x /app/docker-entrypoint.sh /app/run_metabase.sh

ENTRYPOINT ["/app/docker-entrypoint.sh"]
