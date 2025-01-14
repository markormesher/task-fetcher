FROM debian:bookworm-slim@sha256:d365f4920711a9074c4bcd178e8f457ee59250426441ab2a5f8106ed8fe948eb as builder
WORKDIR /

RUN apt update \
  && apt install -y --no-install-recommends ca-certificates wget

ENV TASK_VERSION="v3.40.1"

RUN wget https://github.com/go-task/task/releases/download/${TASK_VERSION}/task_linux_amd64.tar.gz \
  && wget https://github.com/go-task/task/releases/download/${TASK_VERSION}/task_checksums.txt \
  && sha256sum --check --ignore-missing task_checksums.txt \
  && tar xf task_linux_amd64.tar.gz task

# ---

FROM busybox:1.37.0@sha256:a5d0ce49aa801d475da48f8cb163c354ab95cab073cd3c138bd458fc8257fbf1

LABEL image.registry=ghcr.io
LABEL image.name=markormesher/task-fetcher

COPY --from=builder /task /task

CMD ["echo", "The `task` binary is at /task - copy it to wherever you need it"]
