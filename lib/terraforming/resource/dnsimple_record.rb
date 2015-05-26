module Terraforming
  module Resource
    class DNSimpleRecord
      include Terraforming::Util

      def self.tf(client = nil)
        self.new(client).tf
      end

      def self.tfstate(client = nil)
        self.new(client).tfstate
      end

      def initialize(client)
        @client = client
      end

      def tf
        apply_template(@client)
      end

      def tfstate

      end

      private

      # TODO(dtan4): Use terraform's utility method
      def apply_template(client)
        ERB.new(open(template_path).read, nil, "-").result(binding)
      end

      def domains
        @client.domains.list
      end

      def module_name_of(record)
        normalize_module_name(record.name)
      end

      def template_path
        File.join(File.expand_path(File.join(File.dirname(__FILE__), "..")), "template", "tf", "dnsimple_record.erb")
      end

      def records_of(domain)
        @client.domains.records(domain.name)
      end

      def domain_records
        domains.map do |domain|
          { domain: domain.name, records: records_of(domain) }
        end
      end
    end
  end
end
