Dir['./application/*.rb'].each { |file| require file }
Dir['./model/*.rb'].each { |file| require file }
Dir['./model/item/*.rb'].each { |file| require file }

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
GameMaster.start
