# cardano-sl-alpine

> a docker image for cardano-sl based on alpine

[cardano-sl Github Repo](https://github.com/input-output-hk/cardano-sl)

## Usage

There are two ways to use this repo: build docker image or pull docker image.

### Build docker image

`docker build . -f Dockerfile -t [YOUR_DOCKER_TAG_NAME]`

### Pull docker image from docker store

`docker pull sharkspeed/cardano-sl-alpine`

If you want run a cardano node temporarily, your can use this command: 

`docker run --rm -it -p 127.0.0.1:8090:8090 -v $(pwd)/cardano/db:/home/cardano/cardano-sl/db -v $(pwd)/cardano/state-wallet-mainnet:/home/cardano/cardano-sl/state-wallet-mainnet --name cardano-sl sharkspeed/cardano-sl-alpine`

If you want run a cardano node in background:

`docker run -d -p 127.0.0.1:8090:8090 -v $(pwd)/cardano/db:/home/cardano/cardano-sl/db -v $(pwd)/cardano/state-wallet-mainnet:/home/cardano/cardano-sl/state-wallet-mainnet --name cardano-sl sharkspeed/cardano-sl-alpine`

Both of above commands will persist block files to local disk, so your can find block files in `$(pwd)/cardano/state-wallet-mainnet/db/blocks/data`

## Q&A:

- How to test the api of cardano node ?

I don't know why the api of cardano node only can be accessed inside docker.

Go into docker:

`docker exec -it cardano-sl sh`

Test api with curl:

`curl --cacert server.cert https://localhost:8090/api/settings/version` (You can find cert file in `state-wallet-mainnet/tls`)

You can find more apis to have a try [here](https://cardanodocs.com/technical/wallet/api/)

## Others

Please feel free to ask me if you have any questions.

My Cardano Address:

DdzFFzCqrht31ymDDCZVJaBict2ouDS6Y58ZBX8uohwBgcSD6iSivuErhQpSMvZPgrapEJ5CbGMrK2Ga9pMWEGSHS7WtUVCBABCNxUuP
