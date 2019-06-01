# ゲーム進行を行うクラス
class GameMaster
  attr_reader :player_list, :enemy_list
  # クラスインスタンス変数
  @player_list = nil
  @enemy_list = nil
  def initialize(player_list, enemy_list)
    @player_list = player_list
    @enemy_list = enemy_list
  end

  def start
    actor_list = @player_list | @enemy_list # 配列のマージ
    until gameset?
      # 作戦フェーズ
      actor_commands = actor_list.map(&:action)
      # Turn
      Turn.start(actor_commands, turn)
    end
  end

  private 

  # 手持ちのリストを精査して、どちらかのリストでHPが全員0ならTrue
  def gameset?

  end
end