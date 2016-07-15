require 'oystercard'

describe Oystercard do
  subject(:card) { Oystercard.new }

  context 'default' do
    it 'default balance of 0' do
      expect(card.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'adds money to card' do
      expect{ card.top_up(10) }.to change{ card.balance }.by(10)
    end

    it 'error over £90 balance' do
      expect{ card.top_up(100) }.to raise_error('Over max balance')
    end
  end

  context 'when touched' do
    context 'in' do
      it 'set to in journey' do
        card.top_up(10)
        card.touch_in
        expect(card).to be_in_journey
      end

      it 'raise error if balance below fare' do
        expect{ card.touch_in }.to raise_error('Not enough balance for fare')
      end
    end

    context 'out' do
      it 'set to not in journey' do
        card.top_up(10)
        card.touch_in
        card.touch_out
        expect(card).not_to be_in_journey
      end

      it 'deduct fare from balance' do
        card.top_up(10)
        expect{ card.touch_out }.to change{ subject.balance }.by(-Oystercard::FARE)
      end
    end
  end

end
