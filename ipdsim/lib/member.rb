class Member
  attr_accessor :strategy
  attr_accessor :choices
  attr_accessor :health
  attr_accessor :member_id

  def initialize(options)
    @health = World.default_health
    @strategy = options[:strategy]
    @year_of_birth = World.current_year.number
    @strategy.population << self
    @choices = []
    @member_id = "#{@strategy.name.downcase.gsub!('strategy','')}_"+object_id.to_s
  end

  def fight(member)
    raise "Can only fight members" unless member.is_a?(Member)
    a, b = self, member
    20.times do
      unless a.dead? or b.dead?
        a_choice, b_choice = a.strategy.decide_against(b), b.strategy.decide_against(a)
        a.choices << a_choice
        b.choices << b_choice
        outcomes = Strategy.outcomes_from(a_choice,b_choice)
        
        a_last_health = a.health
        b_last_health = b.health

        a.health += outcomes.first
        b.health += outcomes.last
        
        puts "BATTLE: A(#{a.member_id}) chose to #{a_choice}: #{a_last_health} -> #{a.health} B(#{member.member_id}) chose to #{b_choice}: #{b_last_health} -> #{b.health}"
        a.die if a.health <= 0
        b.die if b.health <= 0
      end
    end
    [a,b].each do |x|
      x.reset_choices
    end
  end

  def reset_choices
    @choices = []
  end

  def try_to_survive
    if @health <= World.food_level
      die
    else
      reset_health
      breed!
    end
  end

  def die
    @strategy.population.delete(self)
    puts "#{self.member_id} died!"
  end
  
  def breed!
    if rand(2)==1
      Member.new(:strategy => @strategy) 
      puts "#{self.member_id} breeded!"
    end
  end

  def alive?
    @strategy.population.include?(self)
  end

  def dead?
    not alive?
  end

  private

  def reset_health
    @health = World.default_health
  end

end
