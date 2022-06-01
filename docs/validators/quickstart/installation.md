<!--
order: 1
-->

# Installation

Build and install the Ambinet binaries from source or using Docker. {synopsis}

## Pre-requisites

- [Install Go 1.17.5+](https://golang.org/dl/) {prereq}
- [Install jq](https://stedolan.github.io/jq/download/) {prereq}

## Install Go

::: warning
Ambinet is built using [Go](https://golang.org/dl/) version `1.17.5+`
:::

```bash
go version
```

:::tip
If the `ambinetd: command not found` error message is returned, confirm that your [`GOPATH`](https://golang.org/doc/gopath_code#GOPATH) is correctly configured by running the following command:

```bash
export PATH=$PATH:$(go env GOPATH)/bin
```

:::

## Install Binaries

::: tip
The latest {{ $themeConfig.project.name }} [version](https://github.com/hardiksa/ambinet/releases) is `{{ $themeConfig.project.binary }} {{ $themeConfig.project.latest_version }}`
:::

### GitHub

Clone and build {{ $themeConfig.project.name }} using `git`:

```bash
git clone https://github.com/hardiksa/ambinet.git
cd ambinet
make install
```

Check that the `{{ $themeConfig.project.binary }}` binaries have been successfully installed:

```bash
ambinetd version
```

### Docker

You can build {{ $themeConfig.project.name }} using Docker by running:

```bash
make build-docker
```

The command above will create a docker container: `hardiksahq/ambinet:latest`. Now you can run `ambinetd` in the container.

```bash
docker run -it -p 26657:26657 -p 26656:26656 -v ~/.ambinetd/:/root/.ambinetd hardiksahq/ambinet:latest ambinetd version

# To initialize
# docker run -it -p 26657:26657 -p 26656:26656 -v ~/.ambinetd/:/root/.ambinetd hardiksahq/ambinet:latest ambinetd init test-chain --chain-id test_9000-2

# To run
# docker run -it -p 26657:26657 -p 26656:26656 -v ~/.ambinetd/:/root/.ambinetd hardiksahq/ambinet:latest ambinetd start
```

### Releases

You can also download a specific release available on the {{ $themeConfig.project.name }} [repository](https://github.com/hardiksa/ambinet/releases) or via command line:

```bash
go install github.com/hardiksa/ambinet@latest
```
