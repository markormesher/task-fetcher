FROM debian:13.3-slim@sha256:77ba0164de17b88dd0bf6cdc8f65569e6e5fa6cd256562998b62553134a00ef0 as builder
WORKDIR /

RUN apt update \
  && apt install -y --no-install-recommends ca-certificates wget

ENV TASK_VERSION="v3.48.0"

RUN wget https://github.com/go-task/task/releases/download/${TASK_VERSION}/task_linux_amd64.tar.gz \
  && wget https://github.com/go-task/task/releases/download/${TASK_VERSION}/task_checksums.txt \
  && sha256sum --check --ignore-missing task_checksums.txt \
  && tar xf task_linux_amd64.tar.gz task

# ---

FROM busybox:1.37.0@sha256:2383baad1860bbe9d8a7a843775048fd07d8afe292b94bd876df64a69aae7cb1

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