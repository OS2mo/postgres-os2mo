ARG POSTGRES_VERSION

FROM postgres:${POSTGRES_VERSION} as production

LABEL org.opencontainers.image.title="Postgres OS2mo" \
  org.opencontainers.image.description="A docker image containing Postgres initializer code for LoRa and OS2mo needs." \
  org.opencontainers.image.vendor="Magenta ApS" \
  org.opencontainers.image.licenses="MPL-2.0" \
  org.opencontainers.image.source="https://git.magenta.dk/rammearkitektur/postgres-os2mo"

COPY docker-entrypoint.sh /usr/local/bin/
COPY setup_common.sh /usr/local/bin/
COPY setup_lora.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["exit"]

FROM production as test

LABEL org.opencontainers.image.title="Postgres OS2mo test"

# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y --no-install-recommends \
  "postgresql-$PG_MAJOR-pgtap" \
  && rm -rf /var/lib/apt/lists/*

ENV DB_SUPERUSER=true
