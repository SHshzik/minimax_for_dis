# frozen_string_literal: true

require "./services/get_attack_position11"
require "./services/get_attack_position21"
require "./services/get_attack_position31"
# require './services/get_attack_position12'
# require './services/get_attack_position22'
# require './services/get_attack_position32'

# The GetAttackPosition return needed class
class GetAttackPosition
  class << self
    def call(position)
      Object.const_get("GetAttackPosition#{position.join}")
    end
  end
end
