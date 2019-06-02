Dir['./application/command/*.rb'].each { |file| require file }
require './application/game_master'

# ユーザの選択に応じて、適したコマンドクラスを返すビルダー
class CommandBuilder
  ATTACK = '1'

  class << self
    # プレイヤー用ビルダー
    def select(actor)
      command = nil
      loop do
        p '行動を選択してください.'
        p '---------------'
        p "#{ATTACK}: 攻撃する"
        p '---------------'
        select_value = readline
        next unless [ATTACK].include?(select_value.chomp!)

        case select_value
        when ATTACK
          command = AttackCommand.new(actor, GameMaster.enemy_list)
          break
        end
      end
      command.strategise
    end

    # まもの用ビルダー
    def auto(actor)
      actor.target_ai(GameMaster.player_list)
    end
  end
end
