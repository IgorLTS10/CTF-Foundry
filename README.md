## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```


## Explantion of the script

# testContribute
- Le script émule un attaquant avec 1 ether
- On appelle la fonction contribute avec 0.0005 ether
- On vérifie si la contribution est correctement enregistré

# testFlip
- Le script émule un attaquant qui va se déplacer dans le block suivant pour utiliser le même block hash sur le block précédent
- Le script calcule un hash basé sur le précédent et appele la flipFunction pour voir si le flip est le bon

# testReceive
- On envoie un ether au contrat pour voir s'il le recois

# testPassword
- On envoie un mot de passe prédéfini pour tester

