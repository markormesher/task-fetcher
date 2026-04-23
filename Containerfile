FROM docker.io/debian:13.4-slim@sha256:cedb1ef40439206b673ee8b33a46a03a0c9fa90bf3732f54704f99cb061d2c5a as builder
WORKDIR /

RUN apt update \
  && apt install -y --no-install-recommends ca-certificates wget

ENV TASK_VERSION="v3.50.0"

RUN wget https://github.com/go-task/task/releases/download/${TASK_VERSION}/task_linux_amd64.tar.gz \
  && wget https://github.com/go-task/task/releases/download/${TASK_VERSION}/task_checksums.txt \
  && sha256sum --check --ignore-missing task_checksums.txt \
  && tar xf task_linux_amd64.tar.gz task

# ---

FROM docker.io/busybox:1.37.0@sha256:1487d0af5f52b4ba31c7e465126ee2123fe3f2305d638e7827681e7cf6c83d5e

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
