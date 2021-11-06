# frozen_string_literal: true

require './units/unit'

describe Unit do
  it 'returns to_s' do
    expect(described_class.new([1, 1]).to_s).to eq 'Unit - 0'
  end

  describe '#heal?' do
    it 'returns true' do
      allow_any_instance_of(Unit).to receive(:dmg).and_return(-20)

      expect(described_class.new([1, 1]).heal?).to be_truthy
    end

    it 'returns false' do
      allow_any_instance_of(Unit).to receive(:dmg).and_return(20)

      expect(described_class.new([1, 1]).heal?).to be_falsey
    end
  end
end
