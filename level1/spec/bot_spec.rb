RSpec.describe Bot do
  let(:bot) do
    described_class.new('name' => 'Hal')
  end

  it 'increase won value' do
    before_win = bot.won
    bot.win

    expect(before_win).to eq(bot.won - 1)
  end

  it 'increase lost value' do
    before_loose = bot.lost
    bot.loose

    expect(before_loose).to eq(bot.lost - 1)
  end

  it 'return ying or yang' do
    bot_answer = bot.answer_ying_or_yang('ying')

    expect(%w[ying yang]).to include(bot_answer)
  end
end
