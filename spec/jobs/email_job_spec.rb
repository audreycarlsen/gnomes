require "spec_helper"

describe EmailJob do
  let!(:post) { create(:post) }
  let!(:user) { create(:user) }

  it "sends to user's email address" do
    EmailJob.perform(post.id, user.id)
    expect(ActionMailer::Base.deliveries.last.to).to eq([user.email])
  end
end