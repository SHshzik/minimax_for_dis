# frozen_string_literal: true

require './units/unit'

# The Knight represent Knight hero unit
class Knight < Unit
  def full_hp
    150
  end

  def dmg
    50
  end

  def initiative
    50
  end
end
