class World
  # Contains some of the configuration
  # variables and constants used by other classes.
  @@years = []
  @@food_level = 4

  def self.start
    
  end

  def self.default_health
    10
  end

  def self.current_year
    @@years.last
  end
 
  def self.next_year
    current_year.consolidate if current_year
    @@years << Year.new
    puts "WORLD: Passing on to next year..."
    num = RandomStrategy.population.count
    puts "WORLD: Population: RandomStrategy -> #{num}"
    update_food_level
  end 

  def self.alive?
    Strategy.types.each do |strategy|
      return true if strategy.population.count > 0
    end  
    false
  end

  def self.food_level
    @@food_level
  end

  def self.report
    puts "WORLD SIMULATION REPORT"
    puts "-----------------------"
    print "Year\tFood"
    Strategy.types.each do |strategy|
      print "\t" + strategy.short_name
    end
    print "\n"
    @@years.each do |year|
      print year.number.to_s
      print "\t" + year.food_level.to_s
      Strategy.types.each do |strategy|
        print "\t" + year.composition[strategy.name.to_sym].to_s
      end
      print "\n"
    end

  end

  private

  def self.update_food_level
    @@food_level = rand(4)+6
    puts "WORLD: Food level is now #{@@food_level}"
  end
  

end
