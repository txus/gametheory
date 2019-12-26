class RandomStrategy < Strategy
  @@population = []

  def self.decide_against(enemy)
    # Compute enemy.choices if applicable
    # Since it's a Random Strategy it's simply... random
    [:cooperate,:defect].sample
  end

  def self.short_name
    "rnd"
  end

  def self.<<(member)
    @@population << member if member.is_a?(Member)
  end
  def self.population
    @@population
  end

end
