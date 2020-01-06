# === Bittrex self-integration ===

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
### Common Configurations
| Field  | Type  | Description  |
| ------ | ------ | ------ |
| log | dict | logging setting|
| log.logger | string | logger identify (name) |
| log.level | string | debug", "info", "warning", "error" |
| log.filePath | string | log file path |
| log.outputType | string | “console”: log outputs to the console that iconservice is running.<br>“file”: log outputs to the file path.<br>"console\|file”: log outputs to both console and file.|
| log.rotate | dict | logging.rotate setting |
| log.rotate.type | string | "peroid": rotate by period.<br>"bytes": rotate by maxBytes<br>"period\|bytes": log rotate to both period and bytes.|
| log.rotate.period | string | use logging.TimedRotatingFileHandler<br>'when' ex)daily, weekly, hourly, minutely |
| log.rotate.interval | integer | use logging.TimedRotatingFileHandler<br>'interval' ex) (period: hourly, interval: 24) == (period: daily) |
| log.rotate.maxBytes | integer | use logging.RotatingFileHandler<br>'maxBytes' ex) 10mb == 10 * 1024 * 1024 |
| log.rotate.backupCount | integer | limit log file count |
| putPort | integer | zeromq port(db put) |
| getPort | integer | zeromq port(db get) |

### Wallet Server Configurations
| Field  | Type  | Description  |
| ------ | ------ | ------ |
| host | str | server host |
| port | integer | server port |
| gunicorn | dict | [gunicorn configuration](https://docs.gunicorn.org/en/stable/configure.html#configuration-file) |
| ssl | boolean | ssl enable / disable |
| sslCertPath | string | ssl cert path |
| sslKeyPath | stirng | ssl key path |
| requestMaxSize | integer | How big a request may be (bytes) |

#### example
``` json
{
	"log": {
		"logger": "Server",
		"level": "debug",
		"filePath": "./log/walletserver.log",
		"outputType": "console|file",
		"rotate": {
			"type": "period|bytes",
			"period": "daily",
			"interval": 1,
			"backupCount": 50,
			"maxBytes": 10485760
		}
	},
	"host": "0.0.0.0",
	"port": 9000,
	"gunicorn": {
		"workers": 1,
		"worker_class": "sanic.worker.GunicornWorker",
		"graceful_timeout": 30
	},
	"ssl": true,
	"sslCertPath": "./resources/crt.txt",
	"sslKeyPath": "./resources/key.txt",
	"requestMaxSize": 2097152,
	"putPort": 5000,
	"getPort": 5001
}
```

### Node Server Configurations
| Field  | Type  | Description  |
| ------ | ------ | ------ |
| storagePath | str | storage path |

#### example
``` json
{
	"log": {
		"logger": "DBServer",
		"level": "debug",
		"filePath": "./log/walletdb.log",
		"outputType": "console|file",
		"rotate": {
			"type": "period|bytes",
			"period": "daily",
			"interval": 1,
			"backupCount": 50,
			"maxBytes": 10485760
		}
	},
	"putPort": 5000,
	"getPort": 5001,
	"storagePath": "./.storage"
}
```


### Node Server Configurations
| Field  | Type  | Description  |
| ------ | ------ | ------ |
| host | str | server host |
| port | integer | server port |
| gunicorn | dict | [gunicorn configuration](https://docs.gunicorn.org/en/stable/configure.html#configuration-file) |
| ssl | boolean | ssl enable / disable |
| sslCertPath | string | ssl cert path |
| sslKeyPath | stirng | ssl key path |
| requestMaxSize | integer | How big a request may be (bytes) |
| mainnetUrl | strring | ICON Foundation Node Url |

#### example
``` json
{
	"log": {
		"logger": "Server",
		"level": "debug",
		"filePath": "./log/nodeserver.log",
		"outputType": "console|file",
		"rotate": {
			"type": "period|bytes",
			"period": "daily",
			"interval": 1,
			"backupCount": 50,
			"maxBytes": 10485760
		}
	},
	"host": "0.0.0.0",
	"port": 9000,
	"gunicorn": {
		"workers": 1,
		"worker_class": "sanic.worker.GunicornWorker",
		"graceful_timeout": 30
	},
	"ssl": true,
	"sslCertPath": "./resources/crt.txt",
	"sslKeyPath": "./resources/key.txt",
	"requestMaxSize": 2097152,
	"mainnetUrl": "https://ctz.solidwallet.io"
}
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
