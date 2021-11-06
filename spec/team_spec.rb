# frozen_string_literal: true

require './team'
require './units/empire/warrior/squire'

describe Team do
  describe '#full_hp' do
    it 'returns full hp command' do
      team = [
        Squire.new([1, 1]),
        Squire.new([2, 1])
      ]
      expect(described_class.new(team).full_hp).to eq 200
    end
  end
end
