class Feedback
  class << self
    def export_json(bot, words)
      index = bot.won + bot.lost
      current_json = to_json(index, words, bot)
      json_file = File.read(JSON_FEEDBACK)
      json =
        if json_file.size.zero?
          []
        else
          JSON.parse(json_file)['feedbacks']
        end

      json << current_json
      feedbacks_json = { feedbacks: json }

      File.open(JSON_FEEDBACK, 'w') do |f|
        f.puts(JSON.pretty_generate(feedbacks_json))
      end
    end

    def remove_json_content
      system("> #{JSON_FEEDBACK}")

      File.open(JSON_FEEDBACK, 'w') do |f|
        f.puts(JSON.pretty_generate(feedbacks: []))
      end
    end

    def to_json(index, words, bot)
      {
        index: index,
        game: words.first,
        bot: words.last,
        accuracy: bot.percent_of_wins.round(2)
      }
    end
  end
end
