Dir['./application/*.rb'].each { |file| require file }
Dir['./model/*.rb'].each { |file| require file }

player_list = [Hero.new('ゆうしゃ', 5, 5, 5, 5, 1)]
enemy_list = [Monster.new('スライム', 4, 4, 1, 4, 1)]

GameMaster.set(player_list, enemy_list)
GameMaster.start
