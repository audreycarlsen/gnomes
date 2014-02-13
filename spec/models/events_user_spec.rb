require 'spec_helper'

describe EventsUser do
  describe 'find_or_create_by' do
    let(:rsvp) { create(:rsvp) }

    context 'relationship already in database' do
      it 'finds relationship in database' do  
        expect(EventsUser.find_or_create_by(rsvp.event_id, rsvp.user_id, "yes").id).to eq(rsvp.id)
      end

      it 'updates rsvp response' do
        expect(EventsUser.find_by(event_id: rsvp.event_id, user_id: rsvp.user_id).response).to eq("maybe")
        expect(EventsUser.find_or_create_by(1, 1, "yes").response).to eq("yes")
      end
    end

    context 'relationship not already in database' do
      it 'successfully creates relationship' do  
        expect { EventsUser.find_or_create_by(2, 2, "yes") }.to change{ EventsUser.count }.by(1)
      end

      it 'updates rsvp response' do
        expect(EventsUser.find_or_create_by(2, 2, "yes").response).to eq("yes")
      end
    end
  end
end
