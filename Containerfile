FROM docker.io/debian:13.3-slim@sha256:1d3c811171a08a5adaa4a163fbafd96b61b87aa871bbc7aa15431ac275d3d430 as builder
WORKDIR /

RUN apt update \
  && apt install -y --no-install-recommends ca-certificates wget

ENV TASK_VERSION="v3.49.1"

RUN wget https://github.com/go-task/task/releases/download/${TASK_VERSION}/task_linux_amd64.tar.gz \
  && wget https://github.com/go-task/task/releases/download/${TASK_VERSION}/task_checksums.txt \
  && sha256sum --check --ignore-missing task_checksums.txt \
  && tar xf task_linux_amd64.tar.gz task

# ---

FROM docker.io/busybox:1.37.0@sha256:b3255e7dfbcd10cb367af0d409747d511aeb66dfac98cf30e97e87e4207dd76f

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
