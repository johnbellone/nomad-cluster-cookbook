# nomad-cluster cookbook [![Build Status](https://img.shields.io/travis/johnbellone/nomad-cluster-cookbook.svg)](https://travis-ci.org/johnbellone/nomad-cluster-cookbook) [![Code Quality](https://img.shields.io/codeclimate/github/johnbellone/nomad-cluster-cookbook.svg)](https://codeclimate.com/github/johnbellone/nomad-cluster-cookbook) [![Cookbook Version](https://img.shields.io/cookbook/v/nomad-cluster.svg)](https://supermarket.chef.io/cookbooks/nrpe-ng)

Cluster cookbook which installs and configures a [Nomad][2] cluster.

## Platforms
The following platforms are tested using [Test Kitchen][1]:

- Ubuntu 12.04/14.04/16.04
- CentOS (RHEL) 5/6/7

## Basic Usage
The [default recipe](recipes/default.rb) installs and configures the
Consul Replicate daemon. The
[install resource](libraries/consul_installation.rb) will use the
[archive install provider](libraries/nomad_installation_archive.rb)
for the node's operating system. The configuration of the daemon is
managed through the [config resource](libraries/nomad_config.rb) which
can be tuned with node attributes.

[0]: http://blog.vialstudios.com/the-environment-cookbook-pattern#theapplicationcookbook
[1]: https://github.com/test-kitchen/test-kitchen
[2]: https://www.nomadproject.io/
