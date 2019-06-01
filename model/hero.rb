Dir['../application/*.rb'].each { |file| require file }

class Hero < Actor
  # Override
  def action(enemy_list)
    command = CommandBuilder.select(self, enemy_list)
    
  end
end
