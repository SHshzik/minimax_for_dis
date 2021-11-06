# frozen_string_literal: true

class GetAttackPosition31
  class << self
    def call(_attack_team, def_team)
      def_team.units.filter do |unit|
        next true if unit.position == [3, 1]

        next true if unit.position == [2, 1]

        next true if unit.position == [1, 1] && def_team.get_unit([3, 1]).nil? && def_team.get_unit([2, 1]).nil?

        next true if unit.position == [3, 2] && !def_team.have_first_line?

        next true if unit.position == [2, 2] && !def_team.have_first_line?

        next true if unit.position == [1, 2] && !def_team.have_first_line? && def_team.get_unit([3, 2]).nil? && def_team.get_unit([2, 2]).nil?
      end.map(&:position)
    end
  end
end
