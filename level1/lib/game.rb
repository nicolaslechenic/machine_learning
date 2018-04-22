class Game
  DICO = {
    'yin' => 0.0,
    'yang' => 1.0
  }.freeze

  class << self
    def reward(combo)
      combo_validation(combo)
      words_to_values(combo).inject(:+) == 1.0 ? 1.0 : 0.0
    end

    def word_to_value(word)
      Game::DICO[word]
    end

    def words_to_values(words)
      words.map { |word| word_to_value(word) }
    end

    def value_to_word(value)
      DICO.key(value)
    end

    private

    # Verify that the combo is composed of an Array
    # with yin or yang String values
    def combo_validation(combo)
      combo.each do |word|
        next if %w[yin yang].include?(word)
        raise TypeError, 'Combo have to be an Array of yin or yang values'
      end
    end
  end

  def value
    @value ||= rand(0..1).to_f
  end

  def say_yin_or_yang
    DICO.key(value)
  end
end
