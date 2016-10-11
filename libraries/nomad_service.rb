#
# Cookbook: nomad-cluster
# License: Apache 2.0
#
# Copyright 2016, Bloomberg Finance L.P.
#
require 'poise_service/service_mixin'

module NomadClusterCookbook
  module Resource
    # @since 1.0
    class NomadService < Chef::Resource
      include Poise(parent: :nomad_installation)
      provides(:nomad_service)
      include PoiseService::ServiceMixin

      # @!attribute config_file
      # @return [String]
      attribute(:config_file, kind_of: String)
      # @!attribute program
      # @return [String]
      attribute(:program, kind_of: String, default: lazy { parent.nomad_program })

      attribute(:config, template: true, default_source: lazy { default_config_source })
      # @!attribute config_path
      # @return [String]
      attribute(:config_path, kind_of: String, default: '/etc/nomad.json')
      # @!attribute config_mode
      # @return [String]
      attribute(:config_mode, kind_of: String, default: '0440')

      def default_config_source
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
          rc_file new_resource.config_file do
            type 'json'
            content new_resource.config_content
            user new_resource.user
            group new_resource.group
            mode new_resource.config_mode
          end
        end
        super
      end

      private

      # @api private
      def service_options(service)
        service.command(new_resource.command)
        service.user(new_resource.user)
        service.directory(new_resource.directory)
      end
    end
  end
end
