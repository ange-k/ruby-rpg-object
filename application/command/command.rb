# プレイヤーの行動を実行するときに、ユーザから選択肢を得るコマンドクラス
class Command 
  def strategise
    raise NotImplementedError
    .new("#{self.class}##{__method__} が実装されていません"), '関数未実装エラー'
  end

  def action
    raise NotImplementedError
      .new("#{self.class}##{__method__} が実装されていません"), '関数未実装エラー'
  end
end
