require_relative 'lib/world'
require_relative 'lib/year'
require_relative 'lib/member'

#Strategies
require_relative 'lib/strategy'
require_relative 'lib/cooperator_strategy'
require_relative 'lib/defector_strategy'
require_relative 'lib/random_strategy'

World.next_year

a = Member.new(:strategy => RandomStrategy)
b = Member.new(:strategy => RandomStrategy)
c = Member.new(:strategy => DefectorStrategy)
d = Member.new(:strategy => CooperatorStrategy)

while(World.alive?) do
  World.next_year
  fighters = []
  Strategy.types.each do |strategy|
    fighters += strategy.population 
  end
  fighters.shuffle!
  original_fighters = fighters.dup
  fighters.each do |member|
    fighters.reject!{|x|x==member}.each do |enemy|
      puts "#{member.object_id} fought #{enemy.object_id}"
      member.fight(enemy)
      [member,enemy].each do |subject|
        subject.die if subject.health <= 0
      end
    end
  end

  original_fighters.each {|fighter| fighter.try_to_survive }
  
end

puts "On year #{World.current_year.number}, world population is 0."

World.report

