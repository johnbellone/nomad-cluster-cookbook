#
# Cookbook: nomad
# License: Apache 2.0
#
# Copyright 2015-2016, Bloomberg Finance L.P.
#
require 'poise_service/service_mixin'

module NomadClusterCookbook
  module Resource
    # @since 1.0
    class NomadService < Chef::Resource
      include Poise
      provides(:nomad_service)
      include PoiseService::ServiceMixin

      # @!attribute config_file
      # @return [String]
      attribute(:config_file, kind_of: String)
      # @!attribute program
      # @return [String]
      attribute(:program, kind_of: String, default: '/usr/local/bin/nomad')

      def command
        "#{program}"
      end
    end
  end

  module Provider
    # @since 1.0
    class NomadService < Chef::Provider
      include Poise
      provides(:nomad_service)
      include PoiseService::ServiceMixin

      def action_enable
        notifying_block do

        end
        super
      end

      # @api private
      def service_options(resource)
        resource.command(new_resource.command)
        resource.user(new_resource.user)
        resource.directory(new_resource.directory)
      end
    end
  end
end
