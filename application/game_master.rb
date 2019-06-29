# ゲーム進行を行うクラス
class GameMaster
  # クラスインスタンス変数
  @player_list = nil
  @enemy_list = nil

  class << self
    def set(player_list, enemy_list)
      @player_list = player_list
      @enemy_list = enemy_list
    end

    def player_list
      @player_list
    end

    def enemy_list
      @enemy_list
    end

    def start
      actor_list = @player_list | @enemy_list # 配列のマージ
      until gameset?
        # この時点でHP0なら戦闘に参加させない
        actor_list = actor_list.select do |actor|
          actor.alive?
        end
        # 作戦フェーズ
        actor_commands = actor_list.map(&:action)
        # Turn
        Turn.start(actor_commands)
      end
      print '戦闘に勝利した.' if @enemy_list.all?(&:death?)
      print "#{@player_list.first.name}は 全滅した..." if @player_list.all?(&:death?)
    end

    private

    # 手持ちのリストを精査して、どちらかのリストでHPが全員0ならTrue
    def gameset?
      players = @player_list.all?(&:death?)
      enemies = @enemy_list.all?(&:death?)

      players || enemies
    end
  end
end
