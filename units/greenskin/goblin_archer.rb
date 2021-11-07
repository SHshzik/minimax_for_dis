# frozen_string_literal: true

require './units/unit'

# The Goblin represent goblin unit
class GoblinArcher < Unit
  def full_hp
    40
  end

  def dmg
    15
  end

  def initiative
    50
  end

  def attack_type
    2
  end
end
