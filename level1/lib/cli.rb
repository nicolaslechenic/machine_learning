module BotVsGame
  # Thor is used as Command Line Interface
  # you can type ruby bot_vs_game.rb -h to know more
  class CLI < Thor
    desc '-p --play', "Let's game play [nb_games] times with the bot [bot_name]"
    map %w[-p --play] => :play
    # TODO: need some clean/refacto/doc
    def play(nb_games = 100, bot_name = 'Elvis')
      Feedback.remove_json_content

      nb_games        = nb_games.to_i
      bot             = Bot.new(bot_name)
      array_of_words  = []
      rewards         = []

      Array.new(nb_games) do
        sleep SLEEPER_IN_SEC
        game = Game.new

        array_of_words << [
          game.say_yin_or_yang,
          bot.answer_yin_or_yang(game.say_yin_or_yang)
        ]

        reward = Game.reward(array_of_words.last)
        rewards << [reward]

        reward.zero? ? bot.loose : bot.win

        Feedback.export_json(bot, array_of_words.last)

        combos = array_of_words.map { |words| Game.words_to_values(words) }
        train_datas = Bot.train(combos, rewards)
        bot.brain.train_on_data(train_datas, MAX_EPOCH, MAX_ERRORS, DESIRED_MSE)
      end
    end
  end
end
