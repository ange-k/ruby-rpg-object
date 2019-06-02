class Turn 
  @turn = 0
  class << self
    def start(actor_commnads)
      @turn += 1
      p "-*--*--*-#{@turn}ターン-*--*--*-"
      # spped順にコマンドの実行順序を並び替える
      actor_commnads.sort! do |a, b|
        b.actor.speed <=> a.actor.speed # 降順ソート
      end
      # 実行する(ダックタイピング)
      actor_commnads.map(&:action)
    end
  end
end