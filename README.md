# arc-invoice-hub

USDC invoice registry on Arc testnet.

- Chain ID: `5042002`
- RPC: `https://rpc.testnet.arc.network`
- USDC: `0x3600000000000000000000000000000000000000`
- Explorer: https://testnet.arcscan.app

## Contract

`src/InvoiceHub.sol` accepts USDC payments and emits payment events for accounting.

## Test

```bash
forge test -vv
```
