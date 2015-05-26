module Terraforming
  module DNSimple
    class CLI < Thor
      def self.cli_options
        option :tfstate, type: :boolean
      end

      desc "dnsr", "DNSimple Record"
      cli_options
      def dnsr
        execute(Terraforming::Resource::DNSimpleRecord, options)
      end

      private

      def execute(klass, options)
        puts options[:tfstate] ? klass.tfstate : klass.tf
      end
    end
  end
end
