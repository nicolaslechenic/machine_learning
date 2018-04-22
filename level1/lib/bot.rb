class Bot
  REWARD_DIFF_TOLERANCE = 0.5
  BRAIN_PARAMS = {
    num_inputs: 2,
    hidden_neurons: [2],
    num_outputs: 1
  }.freeze

  class << self
    # return yin or yang randomly
    def random_decision
      Game.value_to_word(rand(0..1).to_f)
    end

    def available_combos(game_key)
      Game::DICO.keys.map { |key| [game_key, key] }
    end

    # Update train data to RubyFann
    def train(combos, rewards)
      RubyFann::TrainData.new(
        inputs: combos,
        desired_outputs: rewards
      )
    end
  end

  attr_accessor :name, :brain, :won, :lost

  def initialize(name)
    @name   = name
    @brain  = RubyFann::Standard.new(BRAIN_PARAMS)
    @won    = 0
    @lost   = 0
  end

  def loose
    self.lost += 1
  end

  def win
    self.won += 1
  end

  def percent_of_wins
    return 0 if (won + lost).zero?

    (won.to_f / (won + lost)) * 100
  end

  # Answer yin or yang randomly if the evaluated difference of
  # reward are too close (REWARD_DIFF_TOLERANCE)
  # else returns the word estimated as being the one with
  # the biggest reward
  #
  # @param [String] game say yin or yang
  # @return [String] bot answer yin or yang
  def answer_yin_or_yang(game_key)
    available_combos  = self.class.available_combos(game_key)
    estimates         = estimates(available_combos)
    min_value         = estimates.min.first
    max_value         = estimates.max.first

    if (max_value - min_value) <= REWARD_DIFF_TOLERANCE
      self.class.random_decision
    else
      take_decision(estimates, available_combos)
    end
  end

  # return yin or yang after evaluation
  def take_decision(estimates, available_combos)
    max_index = estimates.index(estimates.max)

    available_combos[max_index].last
  end

  # estimate which one of the two choices
  # offer the best reward
  def estimates(available_choices)
    available_choices.map { |words| brain.run(Game.words_to_values(words)) }
  end

  def status_color
    if percent_of_wins > 80
      :green
    elsif percent_of_wins > 50
      :yellow
    else
      :red
    end
  end
end
