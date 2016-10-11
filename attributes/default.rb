#
# Cookbook: nomad-cluster
# License: Apache 2.0
#
# Copyright 2016, Bloomberg Finance L.P.
#

default['nomad']['service_user'] = 'nomad'
default['nomad']['service_group'] = 'nomad'
default['nomad']['service_name'] = 'nomad'

default['nomad']['provider'] = 'archive'
default['nomad']['options']['version'] = '0.4.1'
