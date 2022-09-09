# Fleet-rp-scale-test
## Prerequisites
1. Setup the right subscriptions

2. Create fleet for scale-test.sh
```
    $ export LOCATION=<LOCATION>
    $ export GROUP=<GROUP>
    $ export FLEET=<FLEET_NAME>
    $ az group create -l ${LOCATION} -g ${GROUP}
    $ az fleet create -l ${LOCATION} -g ${GROUP} -n ${FLEET} --dns-name-prefix ${FLEET} --debug
    $ echo "Fleet properties"
    $ az fleet get -n $FLEET -g $GROUP
```

2. Create fleet for scale-test-concurrent.sh
```
    $ export FLEET_2=<FLEET_NAME>
    $ az group create -l ${LOCATION} -g ${GROUP}
    $ az fleet create -l ${LOCATION} -g ${GROUP} -n ${FLEET_2} --dns-name-prefix ${FLEET_2} --debug
    $ echo "Fleet properties"
    $ az fleet get -n $FLEET_2 -g $GROUP
```