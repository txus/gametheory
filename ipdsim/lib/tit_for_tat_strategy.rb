class TitForTatStrategy < Strategy
  @@population = []

  def self.decide_against(enemy)
    # We do what they last did unto us (or cooperate if we're first)
    enemy.choices.last || :cooperate
  end

  def self.short_name
    'tft'
  end

  def self.<<(member)
    @@population << member if member.is_a?(Member)
  end
  def self.population
    @@population
  end

end
