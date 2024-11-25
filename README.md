# [Task](https://taskfile.dev) Fetcher

This tiny image contains nothing but the [Task](https://taskfile.dev) binary. It's intended to be used as a CI stage to copy the binary into the workspace as quickly as possible (i.e. quicker than `wget`-ing it from scratch on every build because images are usually cached).

The verison bundled is visible in the `Containerfile` and is updated automatically by [Tedium](https://github.com/markormesher/tedium).
