Dir['./application/*.rb'].each { |file| require file }
Dir['./model/*.rb'].each { |file| require file }
Dir['./model/item/*.rb'].each { |file| require file }
Dir['./model/magic/*.rb'].each { |file| require file }
Dir['./application/ai/*.rb'].each { |file| require file }

# アイテムデータの組み立て
tenku_ken = Equipment.new('天空の剣',30, 0)
tenku_yoroi = Equipment.new('天空の鎧', 0, 25)

# 魔法データの組み立て
fullheal = Magic.new("ベホマ",600, 14, Magic::FRIEND)
midheal = Magic.new("べホイミ",100, 8, Magic::FRIEND)
kazap = Magic.new("ギガデイン",160, 25, Magic::ENEMY)

# プレイヤーデータの組み立て
hero_a = Hero.new('ゆうしゃ', 30, 13, 25, 20, 1)
hero_a.weapon = tenku_ken
hero_a.armor = tenku_yoroi
hero_a.learn([midheal, fullheal, kazap])
player_list = [hero_a]


# 敵データの組み立て
monster_a = Monster.new('すごいホイミスライム', 15, 12, 40, 15, 1)
monster_b = Monster.new('りゅうおう', 40, 28, 55, 85, 1)

monster_a.learn([midheal])
monster_a.ai = HealAI.new(monster_a)
enemy_list = [monster_a, monster_b]

GameMaster.set(player_list, enemy_list)
GameMaster.start
