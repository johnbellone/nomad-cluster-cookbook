#
# Cookbook: nomad-cluster
# License: Apache 2.0
#
# Copyright 2016, Bloomberg Finance L.P.
#

poise_service_user node['nomad']['service_user'] do
  group node['nomad']['service_group']
end

install = nomad_installation node['nomad']['service_name']

nomad_service node['nomad']['service_name'] do
  user node['nomad']['service_user']
  group node['nomad']['service_group']
  node['nomad']['config'].each_pair { |k, v| send(k, v) }
end
