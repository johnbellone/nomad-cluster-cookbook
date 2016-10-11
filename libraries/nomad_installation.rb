#
# Cookbook: nomad-cluster
# License: Apache 2.0
#
# Copyright 2016, Bloomberg Finance L.P.
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
      include Poise(container: true, inversion: true)
      provides(:nomad_installation)
      actions(:create, :remove)
      default_action(:create)

      # @!attribute version
      # The version of Nomad to install.
      # @return [String]
      attribute(:version, kind_of: String, name_attribute: true)

      # @return [String]
      def nomad_program
        provider_for_action(:nomad_program).nomad_program
      end
    end
  end

  module Provider
    # @since 1.0
    class NomadInstallation < Chef::Provider
      include Poise(inversion: :nomad_installation)
      provides(:nomad_installation)

      def action_create
        notifying_block { install_nomad }
      end

      def action_delete
        notifying_block { uninstall_nomad }
      end

      # @abstract
      def nomad_program
        raise NotImplementedError
      end

      private

      # @abstract
      def install_nomad
        raise NotImplementedError
      end

      # @abstract
      def uninstall_nomad
        raise NotImplementedError
      end
    end
  end
end
