# Neon Web3 Proxy Manager

<img src="docs/bnmanag.png" width=1000>

### Automatic loading of Neon Web3 Proxy, installation of postgresql via docker compose, optimization of server performance and connection to the monitoring dashboard
 
The [Neon EVM](https://neon-labs.org/) is an Ethereum-like environment that makes it possible for Solidity contracts and Ethereum-like transactions to function on Solana. In the case of the Neon EVM, Ethereum-like transactions are wrapped into Solana transactions by an intermediary [proxy](https://docs.neon-labs.org/docs/architecture/neon_evm_arch/#neon-web3-proxy-proxy) server and sent to the Neon EVM, which executes them in parallel. To facilitate this parallel execution of smart contracts, the Neon EVM ensures that each contract keeps its data in its own Solana storage, and account balances used to pay for Neon transactions are also separated.

### Neon EVM Operator (operator)
A role performed by a Solana account using a software tool. Within Neon EVM, an operator is provided with software in the form of a proxy in order to fulfill certain functions. The operator can deploy one or more proxies. The operator can also configure one proxy for multiple operators, as well as run several proxies with different settings.




The Ansible scripts that we have created for this purpose are a search for best practices and a call for the community of operators to work together.
Please use them, enjoy them and improve them.

### Quick Install

* Log in to your server
* Create the key pair file (you can also upload it via scp if you prefer):
  ````shell
  nano ~/validator-keypair.json
  ````   
  Paste your key pair, save the file (ctrl-O) and exit (ctrl-X).


  If you have a *vote account* key pair, create the key pair file (or upload it via scp):
  ````shell
   nano ~/vote-account-keypair.json
  ````  
  Paste your key pair, save the file (ctrl-O) and exit (ctrl-X).
* Run this command…

````shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ElagabalxNode/neon-manager/main/install/install_operator.sh)"
````

…and follow the wizard’s instructions (__enter your own Node name!__):

That's it, you are all set!

## links

* [Neon docs](https://docs.neon-labs.org/docs)
* [solana rpc role](https://github.com/rpcpool/solana-rpc-ansible)
* [Neon discord operator chanel](https://discord.gg/vP47VSZsRZ)

## Check out our communiti grow up

- Join our Medium [medium/elagabalx](https://medium.com/elagabalx)
- Join our Discord community [discord/elagabalx](https://discord.gg/5ybg4wV3zU)
- Donate Sol to [ElagabalX Validator Identity Account](https://solanabeach.io/validator/8gJCfKzr55gM6DtAaFqoWjBGAmsJ71mpHem6qJAASBU4) on Solana: 6m5vsg6XfsVUroo1zzZmB4YgFmV6ykLiwEXb6choovpc
