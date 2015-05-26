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
        resources = domain_records.inject({}) do |result, dr|
          domain, records = dr[:domain], dr[:records]

          records.each do |record|
            attributes = {
              "id" => record.id.to_s,
              "name" => record.name,
              "value" => record.content,
              "type" => record.record_type,
              "ttl" => record.ttl.to_s,
              "priority" => record.prio.to_s,
              "domain_id" => record.domain_id.to_s,
              "domain" => domain.name,
              "hostname" => hostname_of(domain, record),
            }

            result["dnsimple_record.#{module_name_of(record)}"] = {
              "type" => "dnsimple_record",
              "primary" => {
                "id" => record.id.to_s,
                "attributes" => attributes,
              }
            }
          end

          result
        end

        generate_tfstate(resources)
      end

      private

      # TODO(dtan4): Use terraform's utility method
      def apply_template(client)
        ERB.new(open(template_path).read, nil, "-").result(binding)
      end

      def domains
        @client.domains.list
      end

      def hostname_of(domain, record)
        if record.name == ""
          domain.name
        else
          "#{record.name}.#{domain.name}"
        end
      end

      def module_name_of(record)
        normalize_module_name("#{record.name}-#{record.record_type}")
      end

      def template_path
        File.join(File.expand_path(File.join(File.dirname(__FILE__), "..")), "template", "tf", "dnsimple_record.erb")
      end

      def records_of(domain)
        @client.domains.records(domain.name)
      end

      def domain_records
        domains.map do |domain|
          { domain: domain, records: records_of(domain) }
        end
      end
    end
  end
end
