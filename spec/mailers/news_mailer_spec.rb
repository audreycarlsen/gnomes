require "spec_helper"

describe NewsMailer do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:mail) { NewsMailer.new_post(post.id, user.id) }

  it 'sends mail to user email' do
    expect(mail.to).to include user.email
  end

  it 'sends mail from admin' do
    expect(mail.from).to include "admin@gnomesweetgnome.com"
  end

  it 'sends sets subject' do
    expect(mail.subject).to eq "New Gnews from Gnome Sweet Gnome!"
  end 
end
