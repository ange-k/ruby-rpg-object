Dir['./application/ai/*.rb'].each { |file| require file }
# まもの
class Monster < Actor
  attr_accessor :ai
  def initialize(name, strength, speed, vitality, intelligence, luck)
    super
    @ai = Basic.new(self)
  end

  def action
    CommandBuilder.auto(self)
  end
end
