class Strategy
  attr_accessor :choices
  def initialize(choices)
    @choices = choices
  end
  def dominates?(strategy)
    # Check if @choices dominate strategy.choices
    @choices.each_with_index do |v,k|
      return false if v <= strategy.choices[k]
    end
    puts "Strategy #{@choices} dominates #{strategy.choices}"
    true
  end
end

class PayoffMatrix
  attr_accessor :matrix

  def initialize(matrix)
    @matrix = [Strategy.new([8,6,14]),
               Strategy.new([6,15,3]),
               Strategy.new([18,6,6])]
  end

  def maximin
   @matrix.collect{|strategy| strategy.choices.min }.max
  end

  def minimax
   @matrix.collect{|strategy| strategy.choices.max }.min
  end

end

class TwoPersonZeroSumGame

  def initialize(payoff_matrix)
    @original_payoff_matrix = PayoffMatrix.new(payoff_matrix)
    @payoff_matrix = @original_payoff_matrix
  end

  def solve
    ###########################################
    # STEPS
    # 1.- Calculate the maximin and the minimax
    # 1b.- If they are unequal, go to step 2
    # 2.- Eliminate all strategies that are dominated
    # 3.- Assign probabilities to each of your strategies so that the outcome of the game will be the same on average whatever your opponent does. Assume your opponent does the same; if the outcome when you use this mixed strategy is the same as the outcome when your opponent uses his or her mixed strategy and if all probabilities are nonnegative, yo have solved the game. If there is a gap between the outcomes or if some of the probabilities are negative, reexamine the game for dominated strategies; if there are none, then this method failed.
    ###########################################
    if @payoff_matrix.maximin == @payoff_matrix.minimax
      puts "Solved! Found the value of the game: #{@payoff_matrix.maximin}"
    else
      eliminate_dominated_strategies 
    end
  end

  def eliminate_dominated_strategies
    @payoff_matrix.matrix.each do |strategy|
      @payoff_matrix.matrix.reject{|s| s == strategy }.each do |other_strategy|
        @payoff_matrix.matrix.delete(other_strategy) if strategy.dominates?(other_strategy)
      end
    end
  end

end

a = TwoPersonZeroSumGame.new([])

a.solve
