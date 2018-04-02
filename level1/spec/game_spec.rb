RSpec.describe Game do
  describe '.reward' do
    it 'return 1.0 when the Array contain ying and yang' do
      reward = described_class.reward(%w[ying yang])

      expect(reward).to eq(1.0)
    end

    it 'return 0.0 reward when the Array does not contain yang' do
      reward = described_class.reward(%w[ying ying])

      expect(reward).to eq(0.0)
    end

    it 'raise NoMethodError when the param is not an Array' do
      expect { described_class.reward('bug') }.to raise_error(NoMethodError)
    end

    it 'raise TypeError when the array contain something else than ying or yang' do
      expect { described_class.reward(['bug', 0.0]) }.to raise_error(TypeError)
    end
  end
end
