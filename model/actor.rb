# Player, Enemyのスーパークラス
# Statusを持ち、ターン中に行動しなければならない
class Actor
  attr_reader :name, :speed, :luck, :hp, :mp # getter. 読み出し専用メソッドの自動実装

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
    @defence = @vitality
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
    p "#{@name} は #{target_actor.name} に 殴りかかった！"
    target_actor.defend(@offense)
  end

  # 攻撃されたら防御する
  def defend(enemy_offense)
    damage = @defence - enemy_offense
    damage >= 0 ? damage : 0
    p "#{name} は #{damage} の ダメージを受けた！"
    @hp -= damage
    damage # Rubyは最後に使われた変数や、関数の戻り値をReturnする(Return省略)
  end

  # 生死を返す
  def alive?
    @hp.positive? # @hp > 0 と同等
  end
end
