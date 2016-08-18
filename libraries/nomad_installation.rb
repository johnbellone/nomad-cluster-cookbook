#
# Cookbook: nomad
# License: Apache 2.0
#
# Copyright 2015-2016, Bloomberg Finance L.P.
#
require 'poise'

module NomadClusterCookbook
  module Resource
    # A `nomad_installation` resource which manages the Nomad
    # installation on a node.
    # @provides nomad_installation
    # @action create
    # @action delete
    # @since 1.0
    class NomadInstallation < Chef::Resource
      include Poise(inversion: true)
      provides(:nomad_installation)
      actions(:create, :remove)
      default_action(:create)

      # @!attribute version
      # The version of Nomad to install.
      # @return [String]
      attribute(:version, kind_of: String)

      # @return [String]
      def nomad_program
        @program ||= provider_for_action(:nomad_program).nomad_program
      end
    end
  end
end
