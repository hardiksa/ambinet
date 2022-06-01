<!--
order: 0
title: "Recovery Overview"
parent:
  title: "recovery"
-->

# `recovery`

Recover tokens that are stuck on unsupported Ambinet accounts.

## Abstract

This document specifies the  `x/recovery` module of the Ambinet Hub.

The `x/recovery` module enables users on Ambinet to recover locked funds that were transferred to accounts whose keys are not supported on Ambinet. This happened in particular after the initial Ambinet launch (`v1.1.2`), where users transferred tokens to a `secp256k1` Ambinet address via IBC in order to [claim their airdrop](https://ambinet.dev/modules/claims/). To be EVM compatible, [keys on Ambinet](https://ambinet.dev/technical_concepts/accounts.html#ambinet-accounts) are generated using the `eth_secp256k1` key type which results in a different address derivation than e.g. the `secp256k1` key type used by other Cosmos chains.

At the time of Ambinet’ relaunch, the value of locked tokens on unsupported accounts sits at $36,291.28 worth of OSMO and $268.86 worth of ATOM tokens according to the [Mintscan](https://www.mintscan.io/ambinet/assets) block explorer. With the `x/recovery` module, users can recover these tokens back to their own addresses in the originating chains by performing IBC transfers from authorized IBC channels (i.e Osmosis for OSMO, Cosmos Hub for ATOM).

## Contents

1. **[Concepts](01_concepts.md)**
2. **[State](02_state.md)**
3. **[Hooks](03_hooks.md)**
4. **[Events](04_events.md)**
5. **[Parameters](05_parameters.md)**
6. **[Clients](06_clients.md)**
