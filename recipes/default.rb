#
# Cookbook: nomad
# License: Apache 2.0
#
# Copyright 2015-2016, Bloomberg Finance L.P.
#
poise_service_user node['nomad']['service_user'] do
  group node['nomad']['service_group']
end

install = nomad_installation node['nomad']['service_name']

nomad_service node['nomad']['service_name'] do
  program install.nomad_program

  user node['nomad']['service_user']
  group node['nomad']['service_group']
end
