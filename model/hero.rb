Dir['../application/*.rb'].each { |file| require file }
require './model/actor'
class Hero < Actor
  # Override
  def action
    CommandBuilder.select(self)
  end
end
