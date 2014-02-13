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

    it 'admin status must be false for a non-admin' do
      expect(user.admin.class).to be(FalseClass)
    end

    it 'must have a uid' do
      user.update(uid: nil)
      expect(user).to_not be_valid
    end

    it 'uid is unique' do
      user2 = build(:user, uid: user.uid)
      expect(user2).to_not be_valid
    end
  end

  describe 'methods' do
    describe 'find_or_create_from_omniauth' do

      context 'user already in database' do
        let(:user) { create(:user) }
        let(:auth_hash) { { "uid" => user.uid, "info" => { "image" => "www.something.com", "name" => "Audrey" } } }

        it 'finds user in database' do  
          expect(User.find_or_create_from_omniauth(auth_hash).uid).to eq(user.uid)
        end
      end

      context 'user not already in database' do
        let(:auth_hash) { { "uid" => "A", "info" => { "image" => "www.something.com", "name" => "Audrey" } } }

        it "successfully creates a user" do
          expect {
            User.find_or_create_from_omniauth(auth_hash)
          }.to change{ User.count }.by(1)
        end
      end
    end
  end
end