# frozen_string_literal: true

require './units/unit'

# The Acolyte represent acolyte unit
class Acolyte < Unit
  def full_hp
    50
  end

  def dmg
    -20
  end

  def initiative
    10
  end

  def attack_type
    2
  end

  def weight
    1.5
  end
end
