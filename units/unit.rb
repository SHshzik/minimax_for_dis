# frozen_string_literal: true

# The Unit class represent base class unit's
class Unit
  attr_reader :current_hp, :position
  # attack_type:
  #   1 - one
  #   2 - one from all
  #   3 - all

  def initialize(position, current_dmg = 0)
    @position = position
    @current_hp = full_hp - current_dmg
  end

  def to_s
    "#{self.class} - #{current_hp}"
  end

  def full_hp
    0
  end

  def dmg
    0
  end

  def attack_type
    1
  end

  def initiative
    0
  end

  def heal?
    dmg.negative?
  end

  def defences
    @defence = true
    @has_move = false
  end

  def undo_defences
    @defence = false
    @has_move = true
  end

  def attack(attack_unit)
    attack_unit.get_dmg(dmg)
    @has_move = false
  end

  def undo_attack(attack_unit)
    attack_unit.undo_dmg(dmg)
    @has_move = true
  end

  def get_dmg(dmg)
    @current_hp -= dmg
    @current_hp = 0 if current_hp.negative?
  end

  def undo_dmg(dmg)
    @current_hp += dmg
    @current_hp = full_hp if @current_hp > full_hp
  end

  def defence
    @defence ||= false
  end

  def can_attack(team)
    position[1] == 1 || !team.have_first_line?
  end
end
