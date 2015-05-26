require "spec_helper"

module Terraforming
  module Resource
    describe DNSimpleRecord do
      let(:api_token) do
        "api_token"
      end

      let(:client) do
        Dnsimple::Client.new(username: username, api_token: api_token)
      end

      let(:username) do
        "user@example.com"
      end

      let(:domains_list_response) do
        [
          {
            domain: {
              id: 1,
              user_id: 21,
              registrant_id: 321,
              name: "example1.com",
              unicode_name: "example1.com",
              token: "domain-token",
              state: "registered",
              language: nil,
              lockable: false,
              auto_renew: true,
              whois_protected: false,
              record_count: 5,
              service_count: 1,
              expires_on: "2015-09-27",
              created_at: "2012-09-27T14:25:57.646Z",
              updated_at: "2014-12-15T20:27:04.552Z",
            }
          },
          {
            domain: {
              id: 2,
              user_id: 22,
              registrant_id: 322,
              name: "example2.com",
              unicode_name: "example2.com",
              token: "domain-token",
              state: "hosted",
              language: nil,
              lockable: false,
              auto_renew: true,
              whois_protected: false,
              record_count: 5,
              service_count: 1,
              expires_on: nil,
              created_at: "2012-09-27T14:25:57.646Z",
              updated_at: "2014-12-15T20:27:04.552Z",
            }
          }
        ]
      end

      let(:domains_list_url) do
        "https://api.dnsimple.com/v1/domains"
      end

      let(:domains_example1_records_response) do
        [
          {
            record: {
              name: "hoge",
              ttl: 60,
              created_at: "2010-07-04T04:41:31Z",
              updated_at: "2010-10-21T15:47:47Z",
              domain_id: 1,
              id: 31,
              content: "192.168.0.1",
              record_type: "A",
              prio: nil
            }
          }
        ]
      end

      let(:domains_example1_records_url) do
        "https://api.dnsimple.com/v1/domains/example1.com/records"
      end

      let(:domains_example2_records_response) do
        [
          {
            record: {
              name: "",
              ttl: 3600,
              created_at: "2010-07-04T04:42:11Z",
              updated_at: "2010-10-21T15:47:47Z",
              pdns_identifier: "40",
              domain_id: 2,
              id: 32,
              content: "192.168.0.2",
              record_type: "A",
              prio: 10
            }
          }
        ]
      end

      let(:domains_example2_records_url) do
        "https://api.dnsimple.com/v1/domains/example2.com/records"
      end

      before do
        stub_request(:get, domains_list_url)
        .to_return(body: JSON.generate(domains_list_response))
        stub_request(:get, domains_example1_records_url)
        .to_return(body: JSON.generate(domains_example1_records_response))
        stub_request(:get, domains_example2_records_url)
        .to_return(body: JSON.generate(domains_example2_records_response))
      end

      describe ".tf" do
        it "should generate tf" do
          expect(described_class.tf(client)).to eq <<-EOS
resource "dnsimple_record" "hoge-A" {
    domain = "example1.com"
    name   = "hoge"
    value  = "192.168.0.1"
    type   = "A"
    ttl    = "60"
}

resource "dnsimple_record" "-A" {
    domain = "example2.com"
    name   = ""
    value  = "192.168.0.2"
    type   = "A"
    ttl    = "3600"
}

          EOS
        end
      end

      describe ".tfstate" do
        it "should generate tfstate" do
          expect(described_class.tfstate(client)).to eq JSON.pretty_generate({
            "version" => 1,
            "serial" => 1,
            "modules" => {
              "path" => [
                "root"
              ],
              "outputs" => {},
              "resources" => {
                "dnsimple_record.hoge-A" => {
                  "type" => "dnsimple_record",
                  "primary" => {
                    "id" => "31",
                    "attributes"=> {
                      "id" => "31",
                      "name" => "hoge",
                      "value" => "192.168.0.1",
                      "type" => "A",
                      "ttl" => "60",
                      "priority" => "",
                      "domain_id" => "1",
                      "domain" => "example1.com",
                      "hostname" => "hoge.example1.com",
                    },
                  }
                },
                "dnsimple_record.-A" => {
                  "type" => "dnsimple_record",
                  "primary" => {
                    "id" => "32",
                    "attributes" => {
                      "id" => "32",
                      "name" => "",
                      "value" => "192.168.0.2",
                      "type" => "A",
                      "ttl" => "3600",
                      "priority" => "10",
                      "domain_id" => "2",
                      "domain" => "example2.com",
                      "hostname" => "example2.com",
                    },
                  }
                }
              }
            }
          })
        end
      end
    end
  end
end
