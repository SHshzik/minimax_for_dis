# frozen_string_literal: true

require './units/unit'

# The Squire represents squire unit
class Squire < Unit
  def full_hp
    100
  end

  def dmg
    25
  end

  def initiative
    50
  end
end
