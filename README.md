# Nebula Lighthouse Container
Dockerized Nebula Lighthouse, with default configuration.

## What is Nebula?
Nebula is a scalable overlay networking tool with a focus on performance, simplicity and security. It lets you seamlessly connect computers anywhere in the world. Nebula is portable, and runs on Linux, OSX, Windows, iOS, and Android. It can be used to connect a small number of computers, but is also able to connect tens of thousands of computers.

Know more about Nebula [here](https://github.com/slackhq/nebula "Nebula Project").

## What is Nebula Lighthouse?
Lighthouse is a discovery node with a routable IP address in a Nebula network. Nebula lighthouses allow nodes to find each other, anywhere in the world. A lighthouse is the only node in a Nebula network whose IP should not change.

## Getting started
You can launch a lighthouse with following steps

1. Create a Nebula signing authority to obtain `ca.crt`. (Please refer to [Nebula Project](https://github.com/slackhq/nebula "Nebula Project"))
2. Using `ca.crt` create a `host.key` and `host.crt` for your lighthouse node. (Please refer to [Nebula Project](https://github.com/slackhq/nebula "Nebula Project"))
3. Place `ca.crt`, `host.key` and `host.crt` files in a folder. (assume `my-lighthouse-certs`).
4. Launch dockerized lighthouse using the docker command
    ```console
    docker run -d -p 4242:4242/udp \
        -v <path-to>/my-lighthouse-certs:/etc/nebula \
        satishpkb/nebula-lighthouse
    ```
    or if you prefer `docker-compose` way, use following `docker-compose.yml`
    ```dockerfile
    version: '3.0'

    services:
    lighthouse:
        image: satishpkb/nebula-lighthouse:latest
        volumes:
        - path-to/my-lighthouse-certs:/etc/nebula
        ports:
        - 4242:4242/udp
    ```

## Custom configuration
Customization of lighthouse can be achieved by copying, editing and using the configuration file `config-lighthouse.yaml`. Use customized configuration file in docker command like

```console
docker run -d -p 4242:4242/udp \
    -v <path-to>/my-lighthouse-certs:/etc/nebula \
    -v <path-to>/custom-lighthouse.yaml:/config/config.yaml \
    satishpkb/nebula-lighthouse
```

## Credits
All credits to the team at Slack Technologies for creating Nebula and other contributors.