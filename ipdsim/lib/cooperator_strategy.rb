class CooperatorStrategy < Strategy
  @@population = []

  def self.decide_against(enemy)
    # Compute enemy.choices if applicable
    # Since it's a Cooperator Strategy it's simply... cooperating
    :cooperate
  end

  def self.short_name
    "coop"
  end

  def self.<<(member)
    @@population << member if member.is_a?(Member)
  end
  def self.population
    @@population
  end

end
