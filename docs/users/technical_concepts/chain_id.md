<!--
order: 3
-->

# Chain ID

Learn about the Ambinet chain-id format {synopsis}

## Official Chain IDs

::: tip
**NOTE**: The latest Chain ID (i.e highest Version Number) is the latest version of the software and mainnet.
:::

:::: tabs
::: tab Mainnet

| Name                                            | Chain ID                                      | Identifier | EIP155 Number                         | Version Number                              |
| ----------------------------------------------- | --------------------------------------------- | ---------- | ------------------------------------- | ------------------------------------------- |
| Ambinet {{ $themeConfig.project.version_number }} | `ambinet_{{ $themeConfig.project.chain_id }}-2` | `ambinet`    | `{{ $themeConfig.project.chain_id }}` | `{{ $themeConfig.project.version_number }}` |
| Ambinet 1                                         | `ambinet_{{ $themeConfig.project.chain_id }}-1` | `ambinet`    | `{{ $themeConfig.project.chain_id }}` | `1`                                         |
:::
::: tab Testnets

| Name                              | Chain ID                                              | Identifier | EIP155 Number                                 | Version Number                                      |
| --------------------------------- | ----------------------------------------------------- | ---------- | --------------------------------------------- | --------------------------------------------------- |
| Ambinet Public Testnet              | `ambinet_{{ $themeConfig.project.testnet_chain_id }}-4` | `ambinet`    | `{{ $themeConfig.project.testnet_chain_id }}` | `{{ $themeConfig.project.testnet_version_number }}` |
| Ambinet Public Testnet              | `ambinet_{{ $themeConfig.project.testnet_chain_id }}-3` | `ambinet`    | `{{ $themeConfig.project.testnet_chain_id }}` | `3`                                                 |
| Olympus Mons Incentivized Testnet | `ambinet_{{ $themeConfig.project.testnet_chain_id }}-2` | `ambinet`    | `{{ $themeConfig.project.testnet_chain_id }}` | `2`                                                 |
| Arsia Mons Testnet                | `ambinet_{{ $themeConfig.project.testnet_chain_id }}-1` | `ambinet`    | `{{ $themeConfig.project.testnet_chain_id }}` | `1`                                                 |

:::
::::

::: tip
You can also lookup the [EIP155](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-155.md) `Chain ID` by referring to [chainlist.org](https://chainlist.org/).
:::

![chainlist.org website](./../../img/chainlist.png)

## The Chain Identifier

Every chain must have a unique identifier or `chain-id`. Tendermint requires each application to
define its own `chain-id` in the [genesis.json fields](https://docs.tendermint.com/master/spec/core/genesis.html#genesis-fields). However, in order to comply with both EIP155 and Cosmos standard for chain upgrades, Ambinet-compatible chains must implement a special structure for their chain identifiers.

## Structure

The Ambinet Chain ID contains 3 main components

- **Identifier**: Unstructured string that defines the name of the application.
- **EIP155 Number**: Immutable [EIP155](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-155.md) `CHAIN_ID` that defines the replay attack protection number.
- **Version Number**: Is the version number (always positive) that the chain is currently running.
This number **MUST** be incremented every time the chain is upgraded or forked in order to avoid network or consensus errors.

### Format

The format for specifying and Ambinet compatible chain-id in genesis is the following:

```bash
{identifier}_{EIP155}-{version}
```

The following table provides an example where the second row corresponds to an upgrade from the first one:

| ChainID        | Identifier | EIP155 Number | Version Number |
| -------------- | ---------- | ------------- | -------------- |
| `ambinet_9000-1` | ambinet      | 9000          | 1              |
| `ambinet_9000-2` | ambinet      | 9000          | 2              |
| `...`          | ...        | ...           | ...            |
| `ambinet_9000-N` | ambinet      | 9000          | N              |
