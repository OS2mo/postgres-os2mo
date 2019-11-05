FROM postgres:9.6.15

LABEL org.opencontainers.image.title="Postgres OS2mo" \
  org.opencontainers.image.description="A docker image containing postgres and the extensions LoRA and OS2mo needs." \
  org.opencontainers.image.vendor="Magenta ApS" \
  org.opencontainers.image.licenses="MPL-2.0" \
  org.opencontainers.image.source="https://git.magenta.dk/rammearkitektur/postgres-os2mo"

COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
