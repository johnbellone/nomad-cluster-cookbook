#
# Cookbook: nomad-cluster
# License: Apache 2.0
#
# Copyright 2016, Bloomberg Finance L.P.
#
require 'poise'

module NomadClusterCookbook
  module Provider
    # A `nomad_installation` provider which installs Nomad from an
    # archive.
    # @provides nomad_installation
    # @action create
    # @action delete
    # @since 1.0
    class NomadInstallationArchive < Chef::Provider
      include Poise(inversion: :nomad_installation)
      provides(:archive)

      # Set the default inversion options.
      # @param [Chef::Node] _node
      # @param [Chef::Resource] resource
      # @return [Hash]
      # @api private
      def self.default_inversion_options(_node, resource)
        super.merge(prefix: '/opt/nomad',
                    archive_url: "https://releases.hashicorp.com/nomad/%{version}/%{basename}",
                    archive_basename: default_archive_basename(node, resource),
                    archive_checksum: default_archive_checksum(node, resource))
      end

      # @return [String]
      # @api private
      def nomad_program
        options.fetch(:program, ::File.join(static_folder, 'bin', 'nomad'))
      end

      # @return [String]
      # @api private
      def static_folder
        ::File.join(options[:prefix], new_resource.version)
      end

      # @param [Chef::Node] node
      # @param [Chef::Resource] resource
      # @return [String]
      def self.default_archive_basename(node, resource)
        case node['kernel']['machine']
        when 'x86_64', 'amd64' then ['nomad', resource.version, node['os'], 'amd64'].join('_')
        when /i\d86/ then ['nomad', resource.version, node['os'], '386'].join('_')
        else ['nomad', resource.version, node['os'], node['kernel']['machine']].join('_')
        end.concat('.zip')
      end

      # @param [Chef::Node] node
      # @param [Chef::Resource] resource
      # @return [String]
      def self.default_archive_checksum(node, resource)
        tag = node['kernel']['machine'] =~ /x86_64/ ? 'amd64' : node['kernel']['machine']
        case [node['os'], tag].join('-')
        when 'darwin-amd64'
          case resource.version
          when '0.4.1' then '5f2d52c73e992313e803fb29b6957ad1b754ed6e68bed5fa9fbe9b8e10a67aeb'
          end
        when 'linux-386'
          case resource.version
          when '0.4.1' then 'fc5b750c9b895f2ddf6d4a6e313d0724f7d0c623ca44119b3cd7732f0b6415ae'
          end
        when 'linux-amd64'
          case resource.version
          when '0.4.1' then '0cdb5dd95c918c6237dddeafe2e9d2049558fea79ed43eacdfcd247d5b093d67'
          end
        when 'linux-arm64'
          case resource.version
          when '0.4.1' then '4cfc7501c277c6b8b3c1af0fd29fac8b2f3cfd7039fd2137a5a3832e642adb38'
          end
        when 'linux-arm'
          case resource.version
          when '0.4.1' then '6f74092e232702bf921e52ed1e2e7e76aeb24ae119802b024b865f81bccca29b'
          end
        when 'windows-386'
          case resource.version
          when '0.4.1' then '16a6751efa0f6278ec34ec79b8ba2ee6fbf3dbd80b79e7fe67128a2d9beeb219'
          end
        when 'windows-amd64'
          case resource.version
          when '0.4.1' then '9940bf71b970df2c9e89ffb8307976a2c2e1d256e80da3767b36d3110594b969'
          end
        end
      end

      private

      def install_nomad
        directory options[:prefix] do
          recursive true
        end

        url = options[:archive_url] % { version: options[:version], basename: options[:archive_basename] }
        poise_archive url do
          destination static_folder
          source_properties checksum: options[:archive_checksum]
          strip_components 0
          not_if { ::File.exist?(nomad_program) }
        end
      end

      def uninstall_nomad
        directory static_folder do
          recursive true
          action :delete
        end
      end
    end
  end
end
