module Terraforming
  module DNSimple
    class CLI < Thor
      def self.cli_options
        option :tfstate, type: :boolean
        option :user, type: :string
        option :token, type: :string
      end

      desc "dnsr", "DNSimple Record"
      cli_options
      def dnsr
        execute(Terraforming::Resource::DNSimpleRecord, options)
      end

      private

      def execute(klass, options)
        client = Dnsimple::Client.new(username: options[:user], api_token: options[:token])
        puts options[:tfstate] ? klass.tfstate(client) : klass.tf(client)
      end
    end
  end
end
