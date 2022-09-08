# Fleet-rp-scale-test
## Prerequisites
1. Setup the right subscriptions

2. Create fleet
```
    $ export LOCATION=<LOCATION>
    $ export GROUP=<GROUP>
    $ export FLEET=<FLEET_NAME>
    $ az group create -l ${LOCATION} -g ${GROUP}
    $ az fleet create -l ${LOCATION} -g ${GROUP} -n ${FLEET} --dns-name-prefix ${FLEET} --debug
    $ echo "Fleet properties"
    $ az fleet get -n $FLEET -g $GROUP
```