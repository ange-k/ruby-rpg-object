# まもの
class Monster < Actor
  def action
    CommandBuilder.auto(self)
  end

  # 基本のAI(攻撃するだけ)
  def target_ai(player_list, monster_list = nil)
    # HP 0以下の相手は含めない
    target_list = player_list.select do |target|
      target.hp.positive?
    end

    target_list.sort! do |a, b|
      a.hp <=> b.hp
    end
    AttackCommand.new(self, nil, target_list.last)
  end
end
