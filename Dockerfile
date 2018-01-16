FROM alpine:latest

MAINTAINER sharkspeed <xiangyuliu@outlook.com>

RUN apk update &&\
    apk add --no-cache git curl bzip2 bash openssl &&\
    adduser -D -u 1000 cardano &&\
    # addgroup cardano root &&\
    mkdir -m 0755 /nix &&\
    chown cardano /nix &&\
    mkdir -p /etc/nix &&\
    echo binary-caches = https://cache.nixos.org https://hydra.iohk.io > /etc/nix/nix.conf &&\
    echo binary-caches-public-keys = hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ= >> /etc/nix/nix.conf &&\
    # main repo
    su - cardano -c 'git clone https://github.com/input-output-hk/cardano-sl.git /home/cardano/cardano-sl'
    # backup repo
    # su - cardano -c 'git clone https://gitee.com/gitbear666/cardano-sl /home/cardano/cardano-sl'

USER cardano
ENV USER cardano

RUN curl https://nixos.org/nix/install | sh

WORKDIR /home/cardano/cardano-sl
RUN git checkout master

RUN . /home/cardano/.nix-profile/etc/profile.d/nix.sh &&\
    nix-build -A cardano-sl-static --cores 0 --max-jobs 2 --no-build-output --out-link cardano-sl-1.0
RUN . /home/cardano/.nix-profile/etc/profile.d/nix.sh &&\
    nix-build -A connectScripts.mainnetWallet -o connect-to-mainnet

USER root
CMD ./connect-to-mainnet
