require_relative '../../rules/base'

RSpec.describe Rules::Base do
  let(:rule) { Rules::Base.new }

  describe '#matches?' do
    it 'should raise NotImplementedError' do
      expect { rule.matches?(nil) }.to raise_error(NotImplementedError)
    end
  end

  describe '#reward' do
    it 'should raise NotImplementedError' do
      expect { rule.reward }.to raise_error(NotImplementedError)
    end
  end
end
