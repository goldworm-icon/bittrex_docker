# bittrex_docker

# === Tutorial ===

ICON Develop team supported Bittrex's self-integration.  
Please try to integrate and reply feedback on slack "coin-icx-bi"

### Requirements
This project requires following environments.
* Docker

### Quick start
* WalletServer container build & run :
```bash
    $ ./01.build_wallet.sh
 ```

* NodeServer container build & run :
```bash
    $ ./02.build_node.sh
 ```

# API Example

## WalletServer

#### Lock
PUT https://x.x.x.x:port/wallet/lock
* This API is not supported on ICON.
* When you call this API, always response 200 status.

#### CreateAddress
POST https://x.x.x.x:port/wallet/address

``` json
# Request
{
	"secret": "abcde",
}

# Response
{
    "address": "hx0ed5504bd944ba047f37a84e511fe206dbd28493"
}
```

#### Transaction
POST https://x.x.x.x:port/wallet/transaction

``` json
# Request
{
	"from": "hx0ed5504bd944ba047f37a84e511fe206dbd20000",
	"to": "hxabcd504bd944ba047f37a84e511fe206dbd2abcd",
	"amount": "10",
	"nonce": "1",
	"fee": null,
	"gasPrice": null,
	"gasLimit": "1000000",
	"secret": "abcde", # need secret!
}

# Response
{
	"data": "iad2ZXJzaW9uozB4M6Rmcm9t2SpoeGRiNDc3MmU0YWQ0ZmFiNTFiYTQ4NmU2ZDJjYTAzYWFmNGVkMGJlMzWidG\/ZKmh4Zjk5NjAyZjQ1YmE4NjY2ODljYjZjN2NhMDE5NGRiNTE4NDMwY2FhMqlzdGVwTGltaXSnMHhmNDI0MKl0aW1lc3RhbXCvMHg1OWE2ZWU5YTVkNTkwo25pZKMweDGldmFsdWWjMHhhpW5vbmNlozB4MKlzaWduYXR1cmXZWGJkZmhCU0p5SE9mRlhhN1ZhMDRMbkduSS9vdElNV0kxZTViekUrSEQxOTA0LzgwSCtyMHdYdmpGWWpadzNJZ2U0WnpaV2ttZ1lQN28wUTN3cS9CSXhBRT0="
}
```

#### Wallet
GET https://x.x.x.x:port/wallet/

``` json
# Request
https://0.0.0.0:9000/wallet/hxbcc4f811772d6a98e061bff5515666635005060e?secret=12345

# Response
{
	"key": "7d4e3eec80026719639ed4dba68916eb94c7a49a053e05c8f9578fe4e5a3d7ea"
}
```

## NodeServer
#### Node
GET https://x.x.x.x:port/node

``` json
# requset

# response
{
	"connectedPeers": 0, #not yet supported
	"height": 12179531,
	"gasPrice": "10000000000"
}
```

### Height
GET https://x.x.x.x:port/node/block/{height}

``` json
# request
https://0.0.0.0:9000/node/block/10

# response
{
	"hash": "9a39a75d7075687f746d61191baf1a1ff3b5bc0acc4a8df0bb872e53e13cdc17",
	"height": "10",
	"transactions": [
		{
			"hash": "0xaf9dce05fefef811a786f892f4b24d8031fd95a11606a450b2246e442bde89e5",
			"payments": {
				"from": "hx0ed5504bd944ba047f37a84e511fe206dbd28493",
				"to": "hxcf05607f22e27183b4908497d20b7a4496bd062c",
				"amount": "20000000000000000"
			}
		}
	]
}
```

#### Hash
GET https://x.x.x.x:port/node/transaction/{hash}

```json
# request
https://0.0.0.0:9000/node/transaction/0xaf9dce05fefef811a786f892f4b24d8031fd95a11606a450b2246e442bde89e5

# response
{
	"hash": "0xaf9dce05fefef811a786f892f4b24d8031fd95a11606a450b2246e442bde89e5",
	"blockHash": "0x9a39a75d7075687f746d61191baf1a1ff3b5bc0acc4a8df0bb872e53e13cdc17",
	"blockHeight": "10",
	"payments": {
		"from": "hx0ed5504bd944ba047f37a84e511fe206dbd28493",
		"to": "hxcf05607f22e27183b4908497d20b7a4496bd062c",
		"amount": "20000000000000000"
	}
}
```

#### Address
GET https://x.x.x.x:port/node/address/{address}

``` json
# request
https://0.0.0.0:9000/node/address/hx1729b35b690d51e9944b2e94075acff986ea0675

# response
{
	"balances": [
		{
			"asset": "icx",
			"balance": 134004127985461883163866706
		}
	],
	"nonce": null
}
```

### Transaction
POST https://x.x.x.x:port/node/transaction?estimate=false|true

``` json
#request estimate: False
https://0.0.0.0:9001/node/transaction?estimate=false
{
	"data": "iad2ZXJzaW9uozB4M6Rmcm9t2SpoeGRiNDc3MmU0YWQ0ZmFiNTFiYTQ4NmU2ZDJjYTAzYWFmNGVkMGJlMzWidG\/ZKmh4Zjk5NjAyZjQ1YmE4NjY2ODljYjZjN2NhMDE5NGRiNTE4NDMwY2FhMqlzdGVwTGltaXSnMHhmNDI0MKl0aW1lc3RhbXCvMHg1OWE2ZWU5YTVkNTkwo25pZKMweDGldmFsdWWjMHhhpW5vbmNlozB4MKlzaWduYXR1cmXZWGJkZmhCU0p5SE9mRlhhN1ZhMDRMbkduSS9vdElNV0kxZTViekUrSEQxOTA0LzgwSCtyMHdYdmpGWWpadzNJZ2U0WnpaV2ttZ1lQN28wUTN3cS9CSXhBRT0="
}

#response estimate: False
{
    "hash": "0xaf9dce05fefef811a786f892f4b24d8031fd95a11606a450b2246e442bde89e5"
}
```

``` json
#request estimate: True
https://0.0.0.0:9001/node/transaction?estimate=true
{
	"data": "iad2ZXJzaW9uozB4M6Rmcm9t2SpoeGRiNDc3MmU0YWQ0ZmFiNTFiYTQ4NmU2ZDJjYTAzYWFmNGVkMGJlMzWidG\/ZKmh4Zjk5NjAyZjQ1YmE4NjY2ODljYjZjN2NhMDE5NGRiNTE4NDMwY2FhMqlzdGVwTGltaXSnMHhmNDI0MKl0aW1lc3RhbXCvMHg1OWE2ZWU5YTVkNTkwo25pZKMweDGldmFsdWWjMHhhpW5vbmNlozB4MKlzaWduYXR1cmXZWGJkZmhCU0p5SE9mRlhhN1ZhMDRMbkduSS9vdElNV0kxZTViekUrSEQxOTA0LzgwSCtyMHdYdmpGWWpadzNJZ2U0WnpaV2ttZ1lQN28wUTN3cS9CSXhBRT0="
}

#response estimate: True
{
	"costEstimate": 100000
}
```
