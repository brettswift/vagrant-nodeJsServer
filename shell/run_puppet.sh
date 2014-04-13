#!/bin/sh

PUPPET_DIR='/vagrant'

# TODO: figure out how to get this working from the vagrant provisioner
# now we run puppet
puppet apply -vv --modulepath=$PUPPET_DIR/modules:$PUPPET_DIR/site $PUPPET_DIR/manifests/site.pp
