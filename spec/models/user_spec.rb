require 'spec_helper'

describe User do
  let(:user) { create(:user) }

  describe 'validates' do
    it 'is valid' do
      expect(user).to be_valid
    end

    it 'must have username' do
      user.update(username: nil)
      expect(user).to_not be_valid
    end

    it 'username is unique' do
      user2 = build(:user, username: user.username)
      expect(user2).to_not be_valid
    end

    it 'must have admin status' do
      user.update(admin: nil)
      expect(user).to_not be_valid
    end

    it 'must have a uid' do
      user.update(uid: nil)
      expect(user).to_not be_valid
    end
  end
end
