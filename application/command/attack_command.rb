# 攻撃コマンドの制御
class AttackCommand < Command
  def initialize(actor, target_list)
    @actor = actor
    @target_list = target_list
    @target = nil
  end

  def strategise
    loop do
      select_target = nil
      p '攻撃対象を選択してください.'
      p '---------------'
      @target_list.each_with_index do |target, idx|
        p "#{idx}: #{target.name}"
      end
      p '---------------'
      select_value = readline
      # 入力が正の整数かつ、敵リストの範囲に収まるか
      next unless select_value.positive? && (@target_list.length <= select_value)

      @target = @target_list[select_value - 1]
      break
    end
    @self
  end

  def action
    # TODO: 既に死んでることを考慮する必要がある
    @actor.attack(@target)
  end
end