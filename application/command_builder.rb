# ユーザの選択に応じて、適したコマンドクラスを返すビルダー
class CommandBuilder
  ATTACK = 1

  def self.select(actor)
    loop do
      p '行動を選択してください.'
      p '---------------'
      p "#{ATTACK}: 攻撃する"
      p '---------------'
      select_value = readline
      next unless [ATTACK].include?(select_value)

      case select_value
      when ATTACK
        return new Command(select_value, Command.ENEMY)
      end
    end
  end
end
