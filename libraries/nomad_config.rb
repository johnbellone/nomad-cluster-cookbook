#
# Cookbook: nomad
# License: Apache 2.0
#
# Copyright 2015-2016, Bloomberg Finance L.P.
#
require 'poise'

module NomadClusterCookbook
  module Resource
    # @provides nomad_config
    # @action create
    # @action delete
    # @since 1.0
    class NomadConfig < Chef::Resource
      include Poise(fused: true)
      provides(:nomad_config)

      # @!attribute owner
      # @return [String]
      attribute(:owner, kind_of: String, default: 'nomad')
      # @!attribute group
      # @return [String]
      attribute(:group, kind_of: String, default: 'nomad')
      # @!attribute mode
      # @return [String]
      attribute(:mode, kind_of: String, default: '0640')

      # @return [Hash]
      def content
      end

      action(:create) do
        rc_file new_resource.path do
          type 'json'
          options new_resource.content
          owner new_resource.owner
          group new_resource.group
          mode new_resource.mode
        end
      end

      action(:delete) do
        file new_resource.path do
          action :delete
        end
      end
    end
  end
end
