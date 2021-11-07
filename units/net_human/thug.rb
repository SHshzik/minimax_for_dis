# frozen_string_literal: true

require './units/unit'

# The Squire represents squire unit
class Thug < Unit
  def full_hp
    65
  end

  def dmg
    25
  end

  def initiative
    65
  end
end
