#!/bin/bash

KEY="mykey"
CHAINID="ambinet_9000-1"
MONIKER="mymoniker"
DATA_DIR=$(mktemp -d -t ambinet-datadir.XXXXX)

echo "create and add new keys"
./ambinetd keys add $KEY --home $DATA_DIR --no-backup --chain-id $CHAINID --algo "eth_secp256k1" --keyring-backend test
echo "init Ambinet with moniker=$MONIKER and chain-id=$CHAINID"
./ambinetd init $MONIKER --chain-id $CHAINID --home $DATA_DIR
echo "prepare genesis: Allocate genesis accounts"
./ambinetd add-genesis-account \
"$(./ambinetd keys show $KEY -a --home $DATA_DIR --keyring-backend test)" 1000000000000000000aambinet,1000000000000000000stake \
--home $DATA_DIR --keyring-backend test
echo "prepare genesis: Sign genesis transaction"
./ambinetd gentx $KEY 1000000000000000000stake --keyring-backend test --home $DATA_DIR --keyring-backend test --chain-id $CHAINID
echo "prepare genesis: Collect genesis tx"
./ambinetd collect-gentxs --home $DATA_DIR
echo "prepare genesis: Run validate-genesis to ensure everything worked and that the genesis file is setup correctly"
./ambinetd validate-genesis --home $DATA_DIR

echo "starting ambinet node $i in background ..."
./ambinetd start --pruning=nothing --rpc.unsafe \
--keyring-backend test --home $DATA_DIR \
>$DATA_DIR/node.log 2>&1 & disown

echo "started ambinet node"
tail -f /dev/null