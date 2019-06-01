Dir['../application/*.rb'].each { |file| require file }

class Hero < Actor
  # Override
  def action()
    command = CommandBuilder.select(self)
  end
end
