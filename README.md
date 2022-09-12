# Fleet-rp-scale-test
## Prerequisites
1. Setup the right subscriptions

2. Give script permission: `chmod +x <script_name.sh>`

3. Test specific:

A. For scale-test.sh
```
    $ export LOCATION=<LOCATION>
    $ export GROUP=<GROUP>
    $ export FLEET=<FLEET_NAME>
    $ az group create -l ${LOCATION} -g ${GROUP}
    $ az fleet create -l ${LOCATION} -g ${GROUP} -n ${FLEET} --dns-name-prefix ${FLEET} --debug
    $ echo "Fleet properties"
    $ az fleet get -n $FLEET -g $GROUP
```