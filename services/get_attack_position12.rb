# frozen_string_literal: true

class GetAttackPosition12
  class << self
    def call(_attack_team, def_team)
      def_team.units.filter do |unit|
        next false if unit.current_hp.zero?

        next true if unit.position == [1, 1]

        next true if unit.position == [2, 1]

        next true if unit.position == [3, 1] &&
          (def_team.get_unit([1, 1]).nil? || def_team.get_unit([1, 1]).current_hp.zero?) &&
          (def_team.get_unit([2, 1]).nil? || def_team.get_unit([2, 1]).current_hp.zero?)

        next true if unit.position == [1, 2] && !def_team.have_first_line?

        next true if unit.position == [2, 2] && !def_team.have_first_line?

        next true if unit.position == [3, 2] &&
          !def_team.have_first_line? &&
          (def_team.get_unit([1, 2]).nil? || def_team.get_unit([1, 2]).current_hp.zero?) &&
          (def_team.get_unit([2, 2]).nil? || def_team.get_unit([2, 2]).current_hp.zero?)
      end.map(&:position)
    end
  end
end
