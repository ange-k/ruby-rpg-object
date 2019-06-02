Dir['../application/*.rb'].each { |file| require file }
require './model/actor'
class Hero < Actor
  attr_writer :weapon, :armor

  # Override
  def initialize(name, strength, speed, vitality, intelligence, luck)
    super
    # 装備パラメータ
    @weapon = nil # 武器
    @armor = nil  # 鎧
  end

  # Override
  def action
    CommandBuilder.select(self)
  end

  # Override
  def offense
    # 親クラスのGetterメソッドの結果に、装備中のアイテムのoffense合計を加える
    super + equip.map(&:offense).sum
  end

  # Override
  def defense
    super + equip.map(&:defense).sum
  end

  private

  def equip
    [@weapon, @armor].compact # 配列からnilを削除し、新しい配列を返す
  end

  # Override
  def attack_msg(target_actor)
    if @weapon
      p "#{name} は #{target_actor.name} に #{@weapon.name}で襲いかかった！！"
    else
      super
    end
  end

  # Override
  def defend_msg(damage)
    if @armor
      p "#{name} は #{@armor.name}の上から #{damage} の ダメージを受けた！ (#{@hp}/#{@max_hp})"
    else
      super
    end
  end
end
