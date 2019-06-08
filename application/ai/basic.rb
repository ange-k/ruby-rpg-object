Dir['./application/command/*.rb'].each { |file| require file }

class Basic

  def initialize(actor)
    @actor = actor
  end

  def build(player_list, monster_list)
    # HP 0以下の相手は含めない
    target_list = player_list.select do |target|
      target.hp.positive?
    end

    target_list.sort! do |a, b|
      a.hp <=> b.hp
    end
    AttackCommand.new(@actor, nil, target_list.last)
  end
end