# frozen_string_literal: true

require "./minimax"

# The Fight class save info about teams and some data
class Fight
  attr_reader :friend_team, :enemy_team, :active_position

  def initialize(friend_team, enemy_team)
    @friend_team = friend_team
    @enemy_team = enemy_team
  end

  def to_s
    "#{friend_team.full_hp} / #{enemy_team.full_hp}"
  end

  def initialize_copy(original_fight)
    @friend_team = original_fight.friend_team.dup
    @enemy_team = original_fight.enemy_team.dup
  end

  def set_active_position(position)
    @active_position = position
  end

  def clear_active_position
    @active_position = nil
  end

  def end?
    friend_team.full_hp.zero? || enemy_team.full_hp.zero?
  end

  def make_move(action)
    if action == "d"
      defences
    else
      attack(action.split(" ").map(&:to_i))
    end
  end

  def undo_move(action)
    if action == "d"
      undo_defences
    else
      undo_attack(action.split(" ").map(&:to_i))
    end
  end

  def defences
    current_active.defences
  end

  def undo_defences
    current_active.undo_defences
  end

  def attack(attack_position)
    attack_unit = get_team(attack_position[0]).get_unit(attack_position[1..2])

    current_active.attack(attack_unit)
  end

  def undo_attack(attack_position)
    attack_unit = get_team(attack_position[0]).get_unit(attack_position[1..2])

    current_active.undo_attack(attack_unit)
  end

  def current_active
    get_team(active_position[0])
      .units
      .find { |unit| unit.position == active_position[1..2] }
  end

  def get_team(number)
    [friend_team, enemy_team][number - 1]
  end

  def get_next_step
    move = nil
    best_score = -Float::INFINITY
    fight_clone = dup

    fight_clone.actions.each do |action|
      fight_clone.make_move(action)
      score = minimax(fight_clone)
      fight_clone.undo_move(action)

      if score > best_score
        best_score = score
        move = action
      end
    end

    move
  end

  def score
    friend_team.full_hp - enemy_team.full_hp
  end

  def actions
    attack_team_number = active_position[0]
    attack_team = get_team(attack_team_number)
    def_team_number = attack_team_number == 1 ? 2 : 1
    def_team = get_team(def_team_number)

    [].tap do |actions|
      actions << "d" if attack_team_number == 1
      if current_active.heal?
        heal_positions = attack_team
                          .get_need_heal_positions
                          .map { |pos| [attack_team_number, *pos].join(" ") }
        actions.append(*heal_positions)
      end

      if current_active.attack_type == 1
        attack_positions = []
        if current_active.can_attack(attack_team)
          attack_positions = def_team
                               .get_can_attack_position(current_active, attack_team)
                               .map { |pos| [def_team_number, *pos].join(" ") }
        end

        actions.append(*attack_positions)
      end
    end
  end
end
