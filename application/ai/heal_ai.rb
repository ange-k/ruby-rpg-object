require_relative './basic'
Dir['./application/command/*.rb'].each { |file| require file }

class HealAI < Basic
  attr_reader :actor
  def initialize(actor)
    super
    @heal_threshold = 30
  end

  def build(player_list, monster_list)
    friend_list = monster_list.select do |friend|
      friend.hp.positive?
    end

    friend_list.sort! do |a, b|
      (b.damaged) <=> (a.damaged)
    end

    # damageを相当数負っているmonsterが居ないなら通常攻撃にする
    return super if friend_list.first.damaged < @heal_threshold

    # 自分の使える回復魔法をチェック
    heal_list = actor.magics.select do |magic|
      magic.type == Magic::FRIEND
    end

    # 今のmpで使用可能な魔法をフィルタ
    heal_list = heal_list.select do |magic|
      (actor.mp - magic.mp) >= 0
    end

    # リストに何も残らなければ攻撃に切り替える
    return super if heal_list.empty?

    # より効率的に回復できる魔法を選択
    heal_list = heal_list.sort do |a, b|
      (actor.damaged - a.effect) <=> (actor.damaged - b.effect)
    end

    return HealCommand.new(actor, heal_list.first, nil, friend_list.first)
  end
end