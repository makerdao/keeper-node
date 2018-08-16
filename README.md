# keeper-node

Simple Bash script which starts Parity node with all accounts unlocked. It assumes all accounts
are secured with the same password.

It is useful when operating keepers, as all of them currently assume that their Ethereum accounts
are permanently unlocked on the node. 

NOTE: If you do not have an account, you will need to create an account with `parity account new` and enter the password into a file named *password* beside the *run-parity.sh* script.

 ## Install
*Ubuntu Server*
```
sudo apt-get install jshon
./run-parity.sh
```
## Regenerate Parity Config
https://paritytech.github.io/parity-config-generator/

 ## Support
<https://chat.makerdao.com/channel/keeper>

## License

See [COPYING](https://github.com/makerdao/keeper-node/blob/master/COPYING) file.
