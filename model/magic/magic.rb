class Magic
  attr_reader :name, :effect, :mp, :type
  FRIEND = 0  # 回復
  ENEMY = 1   # 攻撃

  def initialize(name, effect, mp, type)
    @name = name
    @effect = effect
    @mp = mp
    @type = type
    unless [FRIEND, ENEMY].include?(type)
      raise "規定外の魔法種別"
    end
  end
end