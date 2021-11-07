# frozen_string_literal: true

require './units/unit'

# The Squire represents squire unit
class Peasant < Unit
  def full_hp
    40
  end

  def dmg
    15
  end

  def initiative
    30
  end
end
