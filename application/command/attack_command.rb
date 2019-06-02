# 攻撃コマンドの制御
require_relative './command'
class AttackCommand < Command
  attr_reader :actor
  def initialize(actor, target_list, target = nil)
    @actor = actor
    @target_list = target_list
    @target = target
  end

  def strategise
    # HP 0以下の相手は選択肢に含めない
    target_list = @target_list.select do |target|
      target.hp.positive?
    end
    loop do
      p '攻撃対象を選択してください.'
      p '---------------'
      target_list.each_with_index do |target, idx|
        p "#{idx + 1}: #{target.name}"
      end
      p '---------------'
      select_value = readline.chomp!
      next unless select_value.to_i.to_s == select_value
      select_value = select_value.to_i # 整数変換

      # 入力が正の整数かつ、敵リストの範囲に収まるか
      next unless select_value.positive? && (target_list.length >= select_value)

      @target = target_list[select_value - 1]
      return self
    end
  end

  def action
    # TODO: 既に死んでることを考慮する必要がある
    @actor.attack(@target)
  end
end