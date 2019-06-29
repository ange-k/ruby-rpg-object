Dir['./application/command/*.rb'].each { |file| require file }
require './application/game_master'

# ユーザの選択に応じて、適したコマンドクラスを返すビルダー
class CommandBuilder
  ATTACK = '1'
  MAGIC  = '2'

  class << self
    # プレイヤー用ビルダー
    def select(actor)
      command = nil
      loop do
        puts '行動を選択してください.'
        puts '---------------'
        puts "#{ATTACK}: 攻撃する"
        puts "#{MAGIC}: じゅもん"
        puts '---------------'
        select_value = readline
        next unless [ATTACK, MAGIC].include?(select_value.chomp!)

        case select_value
        when ATTACK
          command = AttackCommand.new(actor, GameMaster.enemy_list)
          break
        when MAGIC
          magic = selectMagic(actor.magics)
          case magic.type
          when Magic::FRIEND
            command = HealCommand.new(actor, magic, GameMaster.player_list)
            break
          when Magic::ENEMY
            command = MagicCommand.new(actor, magic, GameMaster.enemy_list)
            break
          end
        else
          raise '想定外のパラメータ.'
        end
      end
      command.strategise
    end

    # まもの用ビルダー
    def auto(actor)
      actor.ai.build(GameMaster.player_list, GameMaster.enemy_list)
    end

    private

    # 魔法選択
    def selectMagic(magics)
      loop do
        puts 'じゅもんを選択してください.'
        puts '---------------'
        magics.each_with_index do |magic, index|
          puts "#{index + 1} : #{magic.name}(#{magic.mp})"
        end
        puts '---------------'
      select_value = readline.chomp!
      next unless select_value.to_i.to_s == select_value
      select_value = select_value.to_i # 整数変換

      # 入力が正の整数かつ、敵リストの範囲に収まるか
      next unless select_value.positive? && (magics.length >= select_value)
      return magics[select_value - 1]
      end
    end
  end
end
