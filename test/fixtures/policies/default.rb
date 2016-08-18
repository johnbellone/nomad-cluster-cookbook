name 'default'
default_source :community
cookbook 'nomad-cluster', path: '.'
run_list 'nomad-cluster::default'
named_run_list :centos, 'yum::default', run_list
named_run_list :debian, 'apt::default', run_list
override['consul']['config']['bootstrap'] = true
override['consul']['config']['server'] = true
