# /!\ Don't care too much about it
#
# Displayer is just temporary class that allow
# to display feedback through the terminal
# It will be removed soon...
class Displayer
  class << self
    def feedback(bot, reward, words)
      puts double_lines
      puts reward(bot, reward)
      puts line
      puts game_action(words.first)
      puts bot_action(bot, words.last)
      puts line
      puts scores(bot)
      puts accuracy(bot)
      puts double_lines
    end

    private

    def accuracy(bot)
      format(
        LOCALES['bot']['accuracy'], accuracy: bot.percent_of_wins.round(2)
      ).colorize(bot.status_color)
    end

    def game_action(word)
      format(LOCALES['game']['value'], value: word)
    end

    def bot_action(bot, word)
      format(LOCALES['bot']['play'], name: bot.name, answer: word)
    end

    def reward(bot, reward)
      if reward.zero?
        format(
          LOCALES['bot']['loose'],
          name: bot.name
        ).colorize(:red)
      else
        format(LOCALES['bot']['win'], name: bot.name).colorize(:green)
      end
    end

    def scores(bot)
      format(
        LOCALES['game']['status'],
        game_score: bot.lost,
        bot_score: bot.won,
        bot_name: bot.name
      )
    end

    def line
      '-' * 50
    end

    def double_lines
      '=' * 50
    end
  end
end