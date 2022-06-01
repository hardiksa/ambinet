<!--
order: 7
-->

# Clients

A user can query the `x/claims` module using the CLI, gRPC or REST.

## CLI

Find below a list of `ambinetd` commands added with the `x/claims` module. You can obtain the full list by using the `ambinetd -h` command.

### Queries

The `query` commands allow users to query `claims` state.

**`total-unclaimed`**

Allows users to query total amount of unclaimed tokens from the airdrop.

```bash
ambinetd query claims total-unclaimed [flags]
```

**`claims-records`**

Allows users to query all the claims records available.

```bash
ambinetd query claims claims-records [flags]
```

**`claims-record`**

Allows users to query a claims record for a given user.

```bash
ambinetd query claims claims-record [address] [flags]
```

**`params`**

Allows users to query claims params.

```bash
ambinetd query claims params [flags]
```

## gRPC

### Queries

| Verb   | Method                                     | Description                                      |
|--------|--------------------------------------------|--------------------------------------------------|
| `gRPC` | `ambinet.claims.v1.Query/TotalUnclaimed`     | Gets the total unclaimed tokens from the airdrop |
| `gRPC` | `ambinet.claims.v1.Query/ClaimsRecords`      | Gets all registered claims records               |
| `gRPC` | `ambinet.claims.v1.Query/ClaimsRecord`       | Get the claims record for a given user            |
| `gRPC` | `ambinet.claims.v1.Query/Params`             | Gets claims params                               |
| `GET`  | `/ambinet/claims/v1/total_unclaimed`         | Gets the total unclaimed tokens from the airdrop |
| `GET`  | `/ambinet/claims/v1/claims_records`          | Gets all registered claims records               |
| `GET`  | `/ambinet/claims/v1/claims_record/{address}` | Gets a claims record for a given user            |
| `GET`  | `/ambinet/claims/v1/params`                  | Gets claims params                               |
