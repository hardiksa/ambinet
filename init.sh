KEY="mykey"
CHAINID="ambinet_9000-1"
MONIKER="localtestnet"
KEYRING="test"
KEYALGO="eth_secp256k1"
LOGLEVEL="info"
# to trace evm
#TRACE="--trace"
TRACE=""

# validate dependencies are installed
command -v jq > /dev/null 2>&1 || { echo >&2 "jq not installed. More info: https://stedolan.github.io/jq/download/"; exit 1; }

# Reinstall daemon
rm -rf ~/.ambinetd*
make install

# Set client config
ambinetd config keyring-backend $KEYRING
ambinetd config chain-id $CHAINID

# if $KEY exists it should be deleted
ambinetd keys add $KEY --keyring-backend $KEYRING --algo $KEYALGO

# Set moniker and chain-id for Ambinet (Moniker can be anything, chain-id must be an integer)
ambinetd init $MONIKER --chain-id $CHAINID

# Change parameter token denominations to aambinet
cat $HOME/.ambinetd/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="aambinet"' > $HOME/.ambinetd/config/tmp_genesis.json && mv $HOME/.ambinetd/config/tmp_genesis.json $HOME/.ambinetd/config/genesis.json
cat $HOME/.ambinetd/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="aambinet"' > $HOME/.ambinetd/config/tmp_genesis.json && mv $HOME/.ambinetd/config/tmp_genesis.json $HOME/.ambinetd/config/genesis.json
cat $HOME/.ambinetd/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="aambinet"' > $HOME/.ambinetd/config/tmp_genesis.json && mv $HOME/.ambinetd/config/tmp_genesis.json $HOME/.ambinetd/config/genesis.json
cat $HOME/.ambinetd/config/genesis.json | jq '.app_state["evm"]["params"]["evm_denom"]="aambinet"' > $HOME/.ambinetd/config/tmp_genesis.json && mv $HOME/.ambinetd/config/tmp_genesis.json $HOME/.ambinetd/config/genesis.json
cat $HOME/.ambinetd/config/genesis.json | jq '.app_state["inflation"]["params"]["mint_denom"]="aambinet"' > $HOME/.ambinetd/config/tmp_genesis.json && mv $HOME/.ambinetd/config/tmp_genesis.json $HOME/.ambinetd/config/genesis.json

# Set gas limit in genesis
cat $HOME/.ambinetd/config/genesis.json | jq '.consensus_params["block"]["max_gas"]="10000000"' > $HOME/.ambinetd/config/tmp_genesis.json && mv $HOME/.ambinetd/config/tmp_genesis.json $HOME/.ambinetd/config/genesis.json

# Set claims start time
node_address=$(ambinetd keys list | grep  "address: " | cut -c12-)
current_date=$(date -u +"%Y-%m-%dT%TZ")
cat $HOME/.ambinetd/config/genesis.json | jq -r --arg current_date "$current_date" '.app_state["claims"]["params"]["airdrop_start_time"]=$current_date' > $HOME/.ambinetd/config/tmp_genesis.json && mv $HOME/.ambinetd/config/tmp_genesis.json $HOME/.ambinetd/config/genesis.json

# Set claims records for validator account
amount_to_claim=10000
cat $HOME/.ambinetd/config/genesis.json | jq -r --arg node_address "$node_address" --arg amount_to_claim "$amount_to_claim" '.app_state["claims"]["claims_records"]=[{"initial_claimable_amount":$amount_to_claim, "actions_completed":[false, false, false, false],"address":ambinet1wvtx86ds97gd8jff06pz0mlvshedturl87929v}]' > $HOME/.ambinetd/config/tmp_genesis.json && mv $HOME/.ambinetd/config/tmp_genesis.json $HOME/.ambinetd/config/genesis.json

# Set claims decay
cat $HOME/.ambinetd/config/genesis.json | jq -r --arg current_date "$current_date" '.app_state["claims"]["params"]["duration_of_decay"]="1000000s"' > $HOME/.ambinetd/config/tmp_genesis.json && mv $HOME/.ambinetd/config/tmp_genesis.json $HOME/.ambinetd/config/genesis.json
cat $HOME/.ambinetd/config/genesis.json | jq -r --arg current_date "$current_date" '.app_state["claims"]["params"]["duration_until_decay"]="100000s"' > $HOME/.ambinetd/config/tmp_genesis.json && mv $HOME/.ambinetd/config/tmp_genesis.json $HOME/.ambinetd/config/genesis.json

# Claim module account:
# 0xA61808Fe40fEb8B3433778BBC2ecECCAA47c8c47 || ambinet1wvtx86ds97gd8jff06pz0mlvshedturl87929v
cat $HOME/.ambinetd/config/genesis.json | jq -r --arg amount_to_claim "$amount_to_claim" '.app_state["bank"]["balances"] += [{"address":"ambinet1wvtx86ds97gd8jff06pz0mlvshedturl87929v","coins":[{"denom":"aambinet", "amount":$amount_to_claim}]}]' > $HOME/.ambinetd/config/tmp_genesis.json && mv $HOME/.ambinetd/config/tmp_genesis.json $HOME/.ambinetd/config/genesis.json

# disable produce empty block
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.ambinetd/config/config.toml
  else
    sed -i 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.ambinetd/config/config.toml
fi

if [[ $1 == "pending" ]]; then
  if [[ "$OSTYPE" == "darwin"* ]]; then
      sed -i '' 's/create_empty_blocks_interval = "0s"/create_empty_blocks_interval = "30s"/g' $HOME/.ambinetd/config/config.toml
      sed -i '' 's/timeout_propose = "3s"/timeout_propose = "30s"/g' $HOME/.ambinetd/config/config.toml
      sed -i '' 's/timeout_propose_delta = "500ms"/timeout_propose_delta = "5s"/g' $HOME/.ambinetd/config/config.toml
      sed -i '' 's/timeout_prevote = "1s"/timeout_prevote = "10s"/g' $HOME/.ambinetd/config/config.toml
      sed -i '' 's/timeout_prevote_delta = "500ms"/timeout_prevote_delta = "5s"/g' $HOME/.ambinetd/config/config.toml
      sed -i '' 's/timeout_precommit = "1s"/timeout_precommit = "10s"/g' $HOME/.ambinetd/config/config.toml
      sed -i '' 's/timeout_precommit_delta = "500ms"/timeout_precommit_delta = "5s"/g' $HOME/.ambinetd/config/config.toml
      sed -i '' 's/timeout_commit = "5s"/timeout_commit = "150s"/g' $HOME/.ambinetd/config/config.toml
      sed -i '' 's/timeout_broadcast_tx_commit = "10s"/timeout_broadcast_tx_commit = "150s"/g' $HOME/.ambinetd/config/config.toml
  else
      sed -i 's/create_empty_blocks_interval = "0s"/create_empty_blocks_interval = "30s"/g' $HOME/.ambinetd/config/config.toml
      sed -i 's/timeout_propose = "3s"/timeout_propose = "30s"/g' $HOME/.ambinetd/config/config.toml
      sed -i 's/timeout_propose_delta = "500ms"/timeout_propose_delta = "5s"/g' $HOME/.ambinetd/config/config.toml
      sed -i 's/timeout_prevote = "1s"/timeout_prevote = "10s"/g' $HOME/.ambinetd/config/config.toml
      sed -i 's/timeout_prevote_delta = "500ms"/timeout_prevote_delta = "5s"/g' $HOME/.ambinetd/config/config.toml
      sed -i 's/timeout_precommit = "1s"/timeout_precommit = "10s"/g' $HOME/.ambinetd/config/config.toml
      sed -i 's/timeout_precommit_delta = "500ms"/timeout_precommit_delta = "5s"/g' $HOME/.ambinetd/config/config.toml
      sed -i 's/timeout_commit = "5s"/timeout_commit = "150s"/g' $HOME/.ambinetd/config/config.toml
      sed -i 's/timeout_broadcast_tx_commit = "10s"/timeout_broadcast_tx_commit = "150s"/g' $HOME/.ambinetd/config/config.toml
  fi
fi

# Allocate genesis accounts (cosmos formatted addresses)
ambinetd add-genesis-account $KEY 100000000000000000000000000aambinet --keyring-backend $KEYRING

# Update total supply with claim values
validators_supply=$(cat $HOME/.ambinetd/config/genesis.json | jq -r '.app_state["bank"]["supply"][0]["amount"]')
# Bc is required to add this big numbers
# total_supply=$(bc <<< "$amount_to_claim+$validators_supply")
total_supply=100000000000000000000010000
cat $HOME/.ambinetd/config/genesis.json | jq -r --arg total_supply "$total_supply" '.app_state["bank"]["supply"][0]["amount"]=$total_supply' > $HOME/.ambinetd/config/tmp_genesis.json && mv $HOME/.ambinetd/config/tmp_genesis.json $HOME/.ambinetd/config/genesis.json

# Sign genesis transaction
ambinetd gentx $KEY 1000000000000000000000aambinet --keyring-backend $KEYRING --chain-id $CHAINID

# Collect genesis tx
ambinetd collect-gentxs

# Run this to ensure everything worked and that the genesis file is setup correctly
ambinetd validate-genesis

if [[ $1 == "pending" ]]; then
  echo "pending mode is on, please wait for the first block committed."
fi

# Start the node (remove the --pruning=nothing flag if historical queries are not needed)
ambinetd start --pruning=nothing $TRACE --log_level $LOGLEVEL --minimum-gas-prices=0.0001aambinet --json-rpc.api eth,txpool,personal,net,debug,web3
