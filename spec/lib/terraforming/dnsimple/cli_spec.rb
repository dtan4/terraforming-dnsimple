require "spec_helper"

module Terraforming
  module DNSimple
    describe CLI do
      describe "dnsr" do
        context "without --tfstate" do
          it "should export DNSimpleRecord tf" do
            expect(Terraforming::Resource::DNSimpleRecord).to receive(:tf)
            described_class.new.invoke(:dnsr, [], {})
          end
        end

        context "with --tfstate" do
          it "should export DNSimpleRecord tfstate" do
            expect(Terraforming::Resource::DNSimpleRecord).to receive(:tfstate)
            described_class.new.invoke(:dnsr, [], { tfstate: true })
          end
        end
      end
    end
  end
end
