describe Jets::Support::RuntimeVersion do
  subject { described_class.new(base: base) }
  let(:base) { '2.7.1' }

  describe '#local' do
    it 'returns a Gem::Version instance' do
      expect(subject.local).to be_a(Gem::Version)
    end
  end

  describe '#runtime' do
    context 'with an unsupported ruby version' do
      let(:base) { '2.6.6' }

      it 'returns raises Jets::Error' do
        expect { subject.runtime }.to raise_error(Jets::Error)
      end
    end

    context 'with ruby 2.5.X' do
      let(:base) { '2.5.0' }

      it 'returns the correct runtime' do
        expect(subject.runtime).to eq(key: 'ruby2.5', constraint: '~> 2.5.0')
      end
    end

    context 'with ruby 2.7.X' do
      let(:base) { '2.7.1' }

      it 'returns the correct runtime' do
        expect(subject.runtime).to eq(key: 'ruby2.7', constraint: '~> 2.7.0')
      end
    end
  end
end
