# Player, Enemyのスーパークラス
# Statusを持ち、ターン中に行動しなければならない
class Actor
  attr_reader :name, :speed, :luck, :hp, :mp # getter. 読み出し専用メソッドの自動実装
  attr_reader :offense, :defense

  # コンストラクタ. Newしたときに呼ばれる初期化処理
  def initialize(name, strength, speed, vitality, intelligence, luck)
    @name = name
    # 基礎パラメータ
    @strength = strength
    @speed = speed
    @vitality = vitality
    @intelligence = intelligence
    @luck = luck
    # 戦闘用パラメータ
    @max_hp = 50 + (@vitality * 4)
    @max_mp = 10 + (@intelligence * 5)
    @hp = @max_hp
    @mp = @max_mp
    @offense = @strength * 2
    @defense = @vitality
  end

  # 行動する(Actorでは継承先に実装することを強要させる仕組みを用意する)
  # JavaやC#でいうところのinterface。
  def action
    raise NotImplementedError
      .new("#{self.class}##{__method__} が実装されていません"), '関数未実装エラー'
  end

  # 引数に与えられた相手に攻撃する
  def attack(target_actor)
    # defendがdamageをReturnするので、ここでもdamageがReturnされる
    attack_msg(target_actor)
    target_actor.defend(offense)
  end

  # 攻撃されたら防御する
  def defend(enemy_offense)
    damage = defense - enemy_offense
    damage >= 0 ? damage : 0
    @hp -= damage.abs
    defend_msg(damage.abs)
    kill_msg unless @hp.positive?
    damage # Rubyは最後に使われた変数や、関数の戻り値をReturnする(Return省略)
  end

  # 生死を返す
  def alive?
    @hp.positive? # @hp > 0 と同等
  end

  def death?
    !alive?
  end

  private

  def attack_msg(target_actor)
    p "#{name} は #{target_actor.name} に 殴りかかった！"
  end

  def defend_msg(damage)
    p "#{name} は #{damage} の ダメージを受けた！ (#{@hp}/#{@max_hp})"
  end

  def kill_msg
    p "#{name} は たおれた！"
  end
end
