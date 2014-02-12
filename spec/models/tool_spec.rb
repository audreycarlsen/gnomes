require 'spec_helper'

describe Tool do
    let(:tool){ create(:tool) }

    describe "validates" do
      it "is valid" do
        expect( tool).to be_valid
      end

      it "must have a title" do
         tool.update(title: nil)
        expect( tool).to be_invalid
      end
    end
end
