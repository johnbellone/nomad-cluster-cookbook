#
# Cookbook: nomad
# License: Apache 2.0
#
# Copyright 2015-2016, Bloomberg Finance L.P.
#
default['nomad']['service_user'] = 'nomad'
default['nomad']['service_group'] = 'nomad'
default['nomad']['service_name'] = 'nomad'

default['poise-inversion']['nomad']['version'] = '0.4.1'
