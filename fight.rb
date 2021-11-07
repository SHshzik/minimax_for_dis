# frozen_string_literal: true

require "pp"
require "tree"

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

  def minimax(fight, depth, max, prev_action, action_node)
    if fight.end?
      action_node << Tree::TreeNode.new("#{fight.score / depth.to_f}")

      return [fight.score / depth.to_f, prev_action]
    end

    if depth > 10
      action_node << Tree::TreeNode.new("#{fight.score / depth.to_f}")

      return [fight.score / depth.to_f, prev_action]
    end

    fight_clone = fight.dup
    if max
      best_score = -Float::INFINITY
      best_prev_action = nil

      fight_clone.actions.each do |action|
        fight_clone.make_move(action)

        inner_action_node = Tree::TreeNode.new("#{action}")
        action_node << inner_action_node

        action_string = [
          "Кто бил - #{fight_clone.current_active.class}",
          "Действие - #{action}",
          "ХП Команды - #{fight_clone.friend_team.full_hp}",
          "ХП Врага - #{fight_clone.enemy_team.full_hp}"
        ].join("\n")

        fight_clone.update_round

        old_active_position = fight_clone.active_position.dup

        next_active_position = fight_clone.next_active_position.dup

        fight_clone.set_active_position(next_active_position)

        score, full_prev_action = fight_clone.minimax(
          fight_clone,
          depth + 1,
          next_active_position[0] == 1,
          prev_action + [action_string],
          inner_action_node
        )

        if score > best_score
          best_score = score
          best_prev_action = full_prev_action.dup
        end

        fight_clone.set_active_position(old_active_position)
        fight_clone.undo_move(action)
      end

    else
      best_score = Float::INFINITY
      best_prev_action = nil
      fight_clone.actions.each do |action|
        fight_clone.make_move(action)

        inner_action_node = Tree::TreeNode.new("#{action}")
        action_node << inner_action_node

        action_string = [
          "Кто бил - #{fight_clone.current_active.class}",
          "Действие - #{action}",
          "ХП Команды - #{fight_clone.friend_team.full_hp}",
          "ХП Врага - #{fight_clone.enemy_team.full_hp}"
        ].join("\n")

        fight_clone.update_round
        old_active_position = fight_clone.active_position.dup
        next_active_position = fight_clone.next_active_position.dup

        fight_clone.set_active_position(next_active_position)

        score, full_prev_action = fight_clone.minimax(
          fight_clone,
          depth + 1,
          next_active_position[0] == 1,
          prev_action + [action_string],
          inner_action_node
        )

        if score < best_score
          best_score = score
          best_prev_action = full_prev_action.dup
        end

        fight_clone.set_active_position(old_active_position)
        fight_clone.undo_move(action)
      end

    end

    [best_score, best_prev_action]
  end

  def get_next_step
    move = nil
    best_score = -Float::INFINITY
    fight_clone = dup
    best_prev_action = nil

    root_node = Tree::TreeNode.new("#{current_active.class} - #{current_active.position}")

    fight_clone.actions.each do |action|
      fight_clone.make_move(action)

      action_node = Tree::TreeNode.new("#{action}")
      root_node << action_node

      action_string = [
        "Кто бил - #{fight_clone.current_active.class}",
        "Действие - #{action}",
        "ХП Команды - #{fight_clone.friend_team.full_hp}",
        "ХП Врага - #{fight_clone.enemy_team.full_hp}"
      ].join("\n")

      fight_clone.update_round
      old_active_position = fight_clone.active_position.dup
      next_active_position = fight_clone.next_active_position.dup

      fight_clone.set_active_position(next_active_position)

      score, full_prev_action = fight_clone.minimax(
        fight_clone,
        1,
        next_active_position[0] == 1,
        [action_string],
        action_node
      )

      if score > best_score
        best_score = score
        move = action
        best_prev_action = full_prev_action.dup
      end

      fight_clone.set_active_position(old_active_position)
      fight_clone.undo_move(action)
    end

    pp best_prev_action
    p best_score
    root_node.print_tree
    move
  end

  def end_round?
    friend_team.units.filter { |unit| unit.has_move && unit.current_hp.positive? }.count.zero? &&
      enemy_team.units.filter { |unit| unit.has_move && unit.current_hp.positive? }.count.zero?
  end

  def update_round
    return unless end_round?

    friend_team.units.each(&:reload_round)
    enemy_team.units.each(&:reload_round)
  end

  def next_active_position
    first = friend_team
              .units
              .filter { |unit| unit.has_move && unit.current_hp.positive? }
              .map { |unit| [[1, *unit.position], unit.initiative] }

    second = enemy_team
               .units
               .filter { |unit| unit.has_move && unit.current_hp.positive? }
               .map { |unit| [[2, *unit.position], unit.initiative] }

    (first + second).sort_by { |unit| unit[1] }.reverse.first[0]
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
      actions << "d" if attack_team_number == 1 && !current_active.heal?
      actions << "d" if attack_team_number == 2 &&
                        current_active.position[1] == 2 &&
                        current_active.attack_type == 1 &&
                        attack_team.have_first_line?
      if current_active.heal?
        heal_positions = attack_team
                           .get_need_heal_positions
                           .map { |pos| [attack_team_number, *pos].join(" ") }
        actions.append(*heal_positions)
        actions << "d" if heal_positions.empty?
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
