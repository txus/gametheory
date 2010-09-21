class Year
  attr_reader :number
  attr_reader :composition
  attr_reader :food_level

  def initialize
    @number = World.current_year ? World.current_year.number + 1 : 1
    @composition = {}
    @food_level = nil
    @growing_rate = {}
  end

  def consolidate
    Strategy.types.each do |strategy|
      @composition[strategy.name.to_sym] = strategy.population.count
    end
    @food_level = World.food_level
    puts "Year #{@number} consolidated. Composition is #{@composition.inspect}"
  end

end
