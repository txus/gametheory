class Strategy
  
  def self.outcomes_from(a_choice, b_choice)
    # Implement how to compute results on a given fight
    # Suggestion (measured in differential health):
    #          B
    #      C       D
    #  C  1\1    -2\2
    # A
    #  D  2\-2   -1\-1
    #
    if a_choice == :cooperate
      return b_choice == :cooperate ? [1,1] : [-2,2]
    elsif a_choice == :defect
      return b_choice == :cooperate ? [2,-2] : [-1,-1]
    end
  end

  def self.types
    # Typical inheritance problem (who the heck are my children?)
    [CooperatorStrategy,
     DefectorStrategy, 
     RandomStrategy]
  end

end
