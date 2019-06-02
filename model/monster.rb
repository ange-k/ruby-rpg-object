# まもの
class Monster < Actor
  def action
    CommandBuilder.auto(self)
  end

  # 基本のAI(攻撃するだけ)
  def target_ai(player_list)
    player_list.sort! do |a, b|
      a.hp <=> b.hp
    end
    AttackCommand.new(self, nil, player_list.last)
  end
end
