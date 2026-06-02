# arc-invoice-hub

USDC invoice registry on Arc testnet.

- Chain ID: `5042002`
- RPC: `https://rpc.testnet.arc.network`
- USDC: `0x3600000000000000000000000000000000000000`
- Explorer: https://testnet.arcscan.app

## Contract

`src/InvoiceHub.sol` records USDC payments and emits accounting events.

## Build

```bash
forge build
```

## Deployment

- Contract: `0xe047Fe06fF9E505D49c20B6Ec865E143ae5d3745`
- Tx: `inferred-from-nonce`
- Explorer: https://testnet.arcscan.app/address/0xe047Fe06fF9E505D49c20B6Ec865E143ae5d3745
