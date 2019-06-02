Dir['./application/*.rb'].each { |file| require file }
Dir['./model/*.rb'].each { |file| require file }
require_relative 'spec_helper'

describe 'ゲームシステムの検査' do
  context '1VS1の殴り合い' do
    example 'スライム' do
      player_list = [Hero.new('ゆうしゃ', 5, 5, 5, 5, 1)]
      enemy_list = [Monster.new('スライム', 4, 4, 1, 4, 1)]

      allow(ARGF).to receive(:readline) { "1\n" }

      GameMaster.set(player_list, enemy_list)
      GameMaster.start

      expect(enemy_list.all?(&:death?))
    end
  end
end