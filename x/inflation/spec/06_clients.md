<!--
order: 8
-->

# Clients

A user can query the `x/incentives` module using the CLI, JSON-RPC, gRPC or
REST.

## CLI

Find below a list of `ambinetd` commands added with the `x/inflation` module. You
can obtain the full list by using the `ambinetd -h` command.

### Queries

The `query` commands allow users to query `inflation` state.

**`period`**

Allows users to query the current inflation period.

```go
ambinetd query inflation period [flags]
```

**`epoch-mint-provision`**

Allows users to query the current inflation epoch provisions value.

```go
ambinetd query inflation epoch-mint-provision [flags]
```

**`skipped-epochs`**

Allows users to query the current number of skipped epochs.

```go
ambinetd query inflation skipped-epochs [flags]
```

**`total-supply`**

Allows users to query the total supply of tokens in circulation.

```go
ambinetd query inflation total-supply [flags]
```

**`inflation-rate`**

Allows users to query the inflation rate of the current period.

```go
ambinetd query inflation inflation-rate [flags]
```

**`params`**

Allows users to query the current inflation parameters.

```go
ambinetd query inflation params [flags]
```

### Proposals

The `tx gov submit-proposal` commands allow users to query create a proposal
using the governance module CLI:

**`param-change`**

Allows users to submit a `ParameterChangeProposal`.

```bash
ambinetd tx gov submit-proposal param-change [proposal-file] [flags]
```

## gRPC

### Queries

| Verb   | Method                                        | Description                                   |
| ------ | --------------------------------------------- | --------------------------------------------- |
| `gRPC` | `ambinet.inflation.v1.Query/Period`             | Gets current inflation period                 |
| `gRPC` | `ambinet.inflation.v1.Query/EpochMintProvision` | Gets current inflation epoch provisions value |
| `gRPC` | `ambinet.inflation.v1.Query/Params`             | Gets current inflation parameters             |
| `gRPC` | `ambinet.inflation.v1.Query/SkippedEpochs`      | Gets current number of skipped epochs         |
| `gRPC` | `ambinet.inflation.v1.Query/TotalSupply`        | Gets current total supply                     |
| `gRPC` | `ambinet.inflation.v1.Query/InflationRate`      | Gets current inflation rate                   |
| `GET`  | `/ambinet/inflation/v1/period`                  | Gets current inflation period                 |
| `GET`  | `/ambinet/inflation/v1/epoch_mint_provision`    | Gets current inflation epoch provisions value |
| `GET`  | `/ambinet/inflation/v1/skipped_epochs`          | Gets current number of skipped epochs         |
| `GET`  | `/ambinet/inflation/v1/total_supply`          | Gets current total supply                     |
| `GET`  | `/ambinet/inflation/v1/inflation_rate`          | Gets current inflation rate                   |
| `GET`  | `/ambinet/inflation/v1/params`                  | Gets current inflation parameters             |
