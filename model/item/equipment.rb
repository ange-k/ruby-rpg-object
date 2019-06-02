class Equipment
  attr_reader :name, :offense, :defense
  def initialize(name, offense, defense)
    @name = name
    @offense = offense
    @defense = defense
  end
end