FROM docker.io/debian:13.5-slim@sha256:b6e2a152f22a40ff69d92cb397223c906017e1391a73c952b588e51af8883bf8 as builder
WORKDIR /

RUN apt update \
  && apt install -y --no-install-recommends ca-certificates wget

ENV TASK_VERSION="v3.51.1"

RUN wget https://github.com/go-task/task/releases/download/${TASK_VERSION}/task_linux_amd64.tar.gz \
  && wget https://github.com/go-task/task/releases/download/${TASK_VERSION}/task_checksums.txt \
  && sha256sum --check --ignore-missing task_checksums.txt \
  && tar xf task_linux_amd64.tar.gz task

# ---

FROM docker.io/busybox:1.38.0@sha256:b6762ddf4a50aabb5f4d21aa6f447d05d5633fb09f09c08b33f22356a2f98be0

COPY --from=builder /task /task

CMD ["echo", "The `task` binary is at /task - copy it to wherever you need it"]

LABEL image.name=markormesher/task-fetcher
LABEL image.registry=ghcr.io
LABEL org.opencontainers.image.description=""
LABEL org.opencontainers.image.documentation=""
LABEL org.opencontainers.image.title="task-fetcher"
LABEL org.opencontainers.image.url="https://github.com/markormesher/task-fetcher"
LABEL org.opencontainers.image.vendor=""
LABEL org.opencontainers.image.version=""
