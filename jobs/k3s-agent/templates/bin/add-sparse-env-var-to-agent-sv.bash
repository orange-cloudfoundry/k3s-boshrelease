#!/bin/bash

set -x
set -e

#TODO: test whether the bosh job indeed runs as vcap, if running as root, we can remove next line
[ $(id -u) -eq 0 ] || exec sudo $0 $@

if ! grep TAR_OPTIONS /etc/sv/agent/run ; then
  echo "patching /etc/sv/agent/run to inject TAR_OPTIONS as a workaround for https://github.com/orange-cloudfoundry/paas-templates/issues/2060"
  # substitute 3rd line with new export
  # more about this syntax at https://stackoverflow.com/a/9533736/1484823
  sed -i.orig '3s/$^export TAR_OPTIONS=" --sparse "/'
  #FIXME: check that the creation of a backup file /etc/sv/agent/run.orig is ignored by sv
  # if not, replace -i.orig flag by -i flag
else
  echo "/etc/sv/agent/run already contains TAR_OPTIONS"
fi
! diff /etc/sv/agent/run /etc/sv/agent/run.orig