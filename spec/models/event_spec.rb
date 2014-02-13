require 'spec_helper'

describe Event do
  let(:event) { create(:event) }

  describe 'validates' do
    it 'is valid' do
      expect(event).to be_valid
    end

    it 'must have title' do
      event.update(title: nil)
      expect(event).to_not be_valid
    end

    it 'must have a date' do
      event.update(date: nil)
      expect(event).to_not be_valid
    end

    it 'must have a description' do
      event.update(description: nil)
      expect(event).to_not be_valid
    end

    it 'must have a location' do
      event.update(location: nil)
      expect(event).to_not be_valid
    end
  end
end
