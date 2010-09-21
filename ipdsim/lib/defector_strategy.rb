class DefectorStrategy < Strategy
  @@population = []

  def self.decide_against(enemy)
    # Compute enemy.choices if applicable
    # Since it's a Defector Strategy it's simply... defecting
    :defect
  end

  def self.short_name
    'def'
  end

  def self.<<(member)
    @@population << member if member.is_a?(Member)
  end
  def self.population
    @@population
  end

end
