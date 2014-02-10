require 'spec_helper'

describe Post do

  describe "post" do

    let(:post){ create(:post) }

    describe "validates" do
      it "is valid" do
        expect(post).to be_valid
      end

      it "must have a title" do
        post.update(title: nil)
        expect(post).to be_invalid
      end

      it "must have content" do
        post.update(content: nil)
        expect(post).to be_invalid
      end
    end
  end
end
