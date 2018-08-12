#!/bin/bash

cd "$(dirname "$0")"

# Configuration
export PASSWORD_FILE=./password
export RESTART_INTERVAL=60

if [ ! -f ${PASSWORD_FILE} ]; then
    echo "File '${PASSWORD_FILE}' with the account unlock password must exist!"
    exit -1
fi

# Enumerate accounts
export KEYS_DIRECTORY=$HOME/.local/share/io.parity.ethereum/keys/ethereum/
export KEY_FILES=$(find ${KEYS_DIRECTORY} -type f ! -name "address_book.json" ! -name "dapps_*" ! -name ".DS_Store")
export ACCOUNTS=$(for file in ${KEY_FILES}; do cat $file | jshon -e address -u; done)
export ACCOUNTS_COMMA_SEPARATED=$(echo ${ACCOUNTS} | sed 's/ /,/g')

# Run parity
echo ""
echo "Account addresses: ${ACCOUNTS_COMMA_SEPARATED}"
echo "Starting parity..."
echo ""

parity \
    --no-periodic-snapshot \
    --cache-size=4096 \
    --jsonrpc-threads=12 \
    --jsonrpc-server-threads=12 \
    --unlock ${ACCOUNTS_COMMA_SEPARATED} \
    --password ${PASSWORD_FILE}

# If parity died, give the server some time and then restart it.
echo ""
echo "Looks like the node has died."
echo "Waiting ${RESTART_INTERVAL} seconds before starting it again..."
echo ""

sleep ${RESTART_INTERVAL}
exec "./run-parity.sh" "$@"
