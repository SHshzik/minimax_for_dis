# frozen_string_literal: true

require "./team"
require "./units/empire/warrior/squire"
require "./units/greenskin/goblin"

describe Team do
  describe "#full_hp" do
    it "returns full hp command" do
      team = [
        Squire.new([1, 1]),
        Squire.new([2, 1])
      ]
      expect(described_class.new(team).full_hp).to eq 200
    end
  end

  describe "#get_can_attack_position" do
    context "when first row pos" do
      let(:enemy_unit) { Squire.new([1, 1]) }
      let(:enemy_team) { described_class.new([enemy_unit]) }

      it "returns when first row with 2" do
        units = [
          Goblin.new([1, 1]),
          Goblin.new([2, 1])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([1, 1], [2, 1])
        )
      end

      it "returns when first row with 1" do
        units = [
          Goblin.new([1, 1]),
          Goblin.new([3, 1])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([1, 1])
        )
      end

      it "returns when first row with 3" do
        units = [
          Goblin.new([3, 1])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([3, 1])
        )
      end

      it "returns when first row with 12" do
        units = [
          Goblin.new([3, 1]),
          Goblin.new([1, 2])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([3, 1])
        )
      end

      it "returns when first row with 12" do
        units = [
          Goblin.new([1, 2]),
          Goblin.new([2, 2]),
          Goblin.new([3, 2]),
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([1, 2], [2, 2])
        )
      end

      it "returns when first row with 12" do
        units = [
          Goblin.new([3, 2]),
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([3, 2])
        )
      end
    end

    context "when second row pos" do
      let(:enemy_unit) { Squire.new([2, 1]) }
      let(:enemy_team) { described_class.new([enemy_unit]) }

      it "returns when first row with 2" do
        units = [
          Goblin.new([1, 1]),
          Goblin.new([2, 1])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([1, 1], [2, 1])
        )
      end

      it "returns when first row with 1" do
        units = [
          Goblin.new([1, 1]),
          Goblin.new([3, 1])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([1, 1], [3, 1])
        )
      end

      it "returns when first row with 3" do
        units = [
          Goblin.new([3, 1])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([3, 1])
        )
      end

      it "returns when first row with 12" do
        units = [
          Goblin.new([3, 1]),
          Goblin.new([1, 2])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([3, 1])
        )
      end

      it "returns when first row with 12" do
        units = [
          Goblin.new([1, 2]),
          Goblin.new([2, 2]),
          Goblin.new([3, 2]),
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([1, 2], [2, 2], [3, 2])
        )
      end

      it "returns when first row with 12" do
        units = [
          Goblin.new([3, 2])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([3, 2])
        )
      end
    end

    context "when third row pos" do
      let(:enemy_unit) { Squire.new([3, 1]) }
      let(:enemy_team) { described_class.new([enemy_unit]) }

      it "returns when first row with 2" do
        units = [
          Goblin.new([1, 1]),
          Goblin.new([2, 1])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([2, 1])
        )
      end

      it "returns when first row with 1" do
        units = [
          Goblin.new([1, 1]),
          Goblin.new([3, 1])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([3, 1])
        )
      end

      it "returns when first row with 3" do
        units = [
          Goblin.new([3, 1])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([3, 1])
        )
      end

      it "returns when first row with 12" do
        units = [
          Goblin.new([3, 1]),
          Goblin.new([1, 2])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([3, 1])
        )
      end

      it "returns when first row with 12" do
        units = [
          Goblin.new([1, 2]),
          Goblin.new([2, 2]),
          Goblin.new([3, 2]),
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([2, 2], [3, 2])
        )
      end

      it "returns when first row with 12" do
        units = [
          Goblin.new([3, 2])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([3, 2])
        )
      end

      it "returns when first row with 12" do
        units = [
          Goblin.new([1, 2])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([1, 2])
        )
      end
    end

    context "when first row pos 2 col" do
      let(:enemy_unit) { Squire.new([1, 2]) }
      let(:enemy_team) { described_class.new([enemy_unit]) }

      it "returns when first row with 2" do
        units = [
          Goblin.new([1, 1]),
          Goblin.new([2, 1])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([1, 1], [2, 1])
        )
      end

      it "returns when first row with 1" do
        units = [
          Goblin.new([1, 1]),
          Goblin.new([3, 1])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([1, 1])
        )
      end

      it "returns when first row with 3" do
        units = [
          Goblin.new([3, 1])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([3, 1])
        )
      end

      it "returns when first row with 12" do
        units = [
          Goblin.new([3, 1]),
          Goblin.new([1, 2])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([3, 1])
        )
      end

      it "returns when first row with 12" do
        units = [
          Goblin.new([1, 2]),
          Goblin.new([2, 2]),
          Goblin.new([3, 2]),
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([1, 2], [2, 2])
        )
      end

      it "returns when first row with 12" do
        units = [
          Goblin.new([3, 2]),
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([3, 2])
        )
      end
    end

    context "when second row pos 2 col" do
      let(:enemy_unit) { Squire.new([2, 2]) }
      let(:enemy_team) { described_class.new([enemy_unit]) }

      it "returns when first row with 2" do
        units = [
          Goblin.new([1, 1]),
          Goblin.new([2, 1])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([1, 1], [2, 1])
        )
      end

      it "returns when first row with 1" do
        units = [
          Goblin.new([1, 1]),
          Goblin.new([3, 1])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([1, 1], [3, 1])
        )
      end

      it "returns when first row with 3" do
        units = [
          Goblin.new([3, 1])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([3, 1])
        )
      end

      it "returns when first row with 12" do
        units = [
          Goblin.new([3, 1]),
          Goblin.new([1, 2])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([3, 1])
        )
      end

      it "returns when first row with 12" do
        units = [
          Goblin.new([1, 2]),
          Goblin.new([2, 2]),
          Goblin.new([3, 2]),
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([1, 2], [2, 2], [3, 2])
        )
      end

      it "returns when first row with 12" do
        units = [
          Goblin.new([3, 2])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([3, 2])
        )
      end
    end

    context "when third row pos 2 col" do
      let(:enemy_unit) { Squire.new([3, 2]) }
      let(:enemy_team) { described_class.new([enemy_unit]) }

      it "returns when first row with 2" do
        units = [
          Goblin.new([1, 1]),
          Goblin.new([2, 1])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([2, 1])
        )
      end

      it "returns when first row with 1" do
        units = [
          Goblin.new([1, 1]),
          Goblin.new([3, 1])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([3, 1])
        )
      end

      it "returns when first row with 3" do
        units = [
          Goblin.new([3, 1])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([3, 1])
        )
      end

      it "returns when first row with 12" do
        units = [
          Goblin.new([3, 1]),
          Goblin.new([1, 2])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([3, 1])
        )
      end

      it "returns when first row with 12" do
        units = [
          Goblin.new([1, 2]),
          Goblin.new([2, 2]),
          Goblin.new([3, 2]),
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([2, 2], [3, 2])
        )
      end

      it "returns when first row with 12" do
        units = [
          Goblin.new([3, 2])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([3, 2])
        )
      end

      it "returns when first row with 12" do
        units = [
          Goblin.new([1, 2])
        ]
        team = described_class.new(units)

        expect(team.get_can_attack_position(enemy_unit, enemy_team)).to(
          contain_exactly([1, 2])
        )
      end
    end
  end
end
