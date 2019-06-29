# Player, Enemyのスーパークラス
# Statusを持ち、ターン中に行動しなければならない
class Actor
  attr_reader :name, :speed, :luck, :hp, :mp # getter. 読み出し専用メソッドの自動実装
  attr_reader :offense, :defense, :random
  attr_reader :magics

  # コンストラクタ. Newしたときに呼ばれる初期化処理
  def initialize(name, strength, speed, vitality, intelligence, luck)
    @name = name
    # 基礎パラメータ
    @strength = strength # 物理攻撃力に影響
    @speed = speed # 行動順に影響
    @vitality = vitality # HP最大値、及び防御力に影響
    @intelligence = intelligence # MP最大値に影響
    @luck = luck # 状態異常の判定に用いる. TODO: 状態異常の実装
    # 戦闘用パラメータ
    @max_hp = 50 + (@vitality * 4)
    @max_mp = 10 + (@intelligence * 5)
    @hp = @max_hp
    @mp = @max_mp
    @offense = @strength * 2
    @defense = @vitality
    # 魔法取得リスト
    @magics = []
    # 乱数生成オブジェクト
    @random = Random.new
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

  # 引数に与えられた相手に魔法で攻撃する
  def attack_magic(target_actor, magic)
    if (mp - magic.mp) < 0
      # mp切れ
      mp_out_msg
    else
      @mp -= magic.mp
      magic_msg(target_actor, magic)
      target_actor.defend(magic.effect)
    end
  end

  # 引数に与えられた相手に魔法で回復する
  def heal_magic(target_actor, magic)
    if (mp - magic.mp) < 0
      # mp切れ
      mp_out_msg
    else
      @mp -= magic.mp
      magic_msg(target_actor, magic)
      target_actor.heal(magic.effect)
    end
  end

  # 攻撃されたら防御する
  # TODO: 魔法でcriticalしないようにする
  def defend(enemy_offense)
    if(critical?)
      damage = enemy_offense * 2
      critical_damaged_msg
    else
      damage = defense - enemy_offense
      damage >= 0 ? damage : 0
    end
    @hp -= damage.abs
    defend_msg(damage.abs)
    kill_msg unless @hp.positive?
    damage # Rubyは最後に使われた変数や、関数の戻り値をReturnする(Return省略)
  end

  def critical?
    # 会心(痛恨)の一撃の判定
    random.rand(1..32) == 16 # 1/32が言いたいだけ
  end

  # 回復を受ける
  def heal(effect)
    if (hp + effect) > @max_hp
      @hp = @max_hp
    else
      @hp += effect
    end
    heal_msg(effect)
  end

  # 生死を返す
  def alive?
    @hp.positive? # @hp > 0 と同等
  end

  def death?
    !alive?
  end

  # 受けているダメージを返す
  def damaged
    @max_hp - @hp
  end

  # 魔法を覚える
  def learn(magic_list)
    @magics = magics | magic_list
  end

  private

  # 戦闘メッセージ
  def attack_msg(target_actor)
    puts "#{name} は #{target_actor.name} に 殴りかかった！"
  end

  def defend_msg(damage)
    puts "#{name} は #{damage} の ダメージを受けた！ (#{@hp}/#{@max_hp})"
  end

  def critical_damaged_msg
    print "★会心の一撃! "
  end

  def magic_msg(target_actor, magic)
    puts "#{name} は #{target_actor.name} に #{magic.name}を唱えた！ MP(#{@mp}/#{@max_mp})"
  end

  def mp_out_msg()
    puts "しかし、MPが足りない！"
  end

  def heal_msg(effect)
    puts "#{name} は HPを #{effect} 回復した！"
  end

  def kill_msg
    puts "#{name} は たおれた！"
  end
end
