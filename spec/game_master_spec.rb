Dir['./application/*.rb'].each { |file| require file }
Dir['./model/*.rb'].each { |file| require file }
Dir['./model/item/*.rb'].each { |file| require file }
Dir['./model/magic/*.rb'].each { |file| require file }
Dir['./application/ai/*.rb'].each { |file| require file }

require_relative 'spec_helper'

describe 'ゲームシステムの検査' do
  context '1VS1の殴り合い' do
    example 'スライム' do
      player_list = [Hero.new('ゆうしゃ', 5, 5, 5, 5, 1)]
      enemy_list = [Monster.new('スライム', 4, 4, 1, 4, 1)]

      allow(ARGF).to receive(:readline) { "1\n" }

      GameMaster.set(player_list, enemy_list)
      GameMaster.start

      expect(GameMaster.send(:gameset?))
    end
  end

  context '1VS2の殴り合い + アイテム装備' do
    example 'まもののむれ' do
      # アイテムデータの組み立て
      hinoki_bou = Equipment.new('ひのきのぼう',5, 0)
      kawa_huku = Equipment.new('かわのふく', 0, 2)

      # プレイヤーデータの組み立て
      hero_a = Hero.new('ゆうしゃ', 5, 5, 5, 5, 1)
      hero_a.weapon = hinoki_bou
      hero_a.armor = kawa_huku
      player_list = [hero_a]

      # 敵データの組み立て
      monster_a = Monster.new('スライム', 4, 4, 1, 4, 1)
      monster_b = Monster.new('おおがらす', 4, 6, 2, 4, 1)
      enemy_list = [monster_a, monster_b]

      GameMaster.set(player_list, enemy_list)

      # Mock
      allow(ARGF).to receive(:readline) { "1\n" }

      GameMaster.start

      expect(GameMaster.send(:gameset?))
    end
  end

  context '1VS2の戦い, アイテム装備, 魔法あり' do
    example 'まもののむれ' do
      hinoki_bou = Equipment.new('ひのきのぼう',5, 0)
      kawa_huku = Equipment.new('かわのふく', 0, 2)

      magic = Magic.new("ホイミ",30, 6, Magic::FRIEND)
      magic_b = Magic.new("メラ",22, 6, Magic::ENEMY)

      hero_a = Hero.new('ゆうしゃ', 5, 5, 5, 5, 1)
      hero_a.weapon = hinoki_bou
      hero_a.armor = kawa_huku
      hero_a.learn([magic, magic_b])
      player_list = [hero_a]

      monster_a = Monster.new('ホイミスライム', 2, 4, 1, 4, 1)
      monster_b = Monster.new('おおがらす', 4, 6, 2, 4, 1)

      monster_a.learn([magic])
      monster_a.ai = HealAI.new(monster_a)
      enemy_list = [monster_a, monster_b]

      GameMaster.set(player_list, enemy_list)
      # Mock
      allow(ARGF).to receive(:readline) { "1\n" }
      GameMaster.start
      expect(GameMaster.send(:gameset?))
    end
  end
end