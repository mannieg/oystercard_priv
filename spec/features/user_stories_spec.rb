require 'oystercard'

describe 'User stories' do
  subject(:card) { Oystercard.new }
  # In order to use public transport
  # As a customer
  # I want money on my card
  it 'balance of Oystercard should be 0 by default' do
    expect(card.balance).to eq 0
  end

  # In order to keep using public transport
  # As a customer
  # I want to add money to my card
  it 'adds money to the card' do
    expect{ card.top_up(10) }.to change{ card.balance }.by(10)
  end
  # In order to protect my money
  # As a customer
  # I don't want to put too much money on my card
  it 'Max balance of 90 allowed' do
    expect{ card.top_up(100) }.to raise_error('Over max balance')
  end
  # In order to pay for my journey
  # As a customer
  # I need my fare deducted from my card
  it 'Deduct money from balance' do
    expect{ card.touch_out }.to change{ card.balance }.by(-Oystercard::FARE)
  end

  # In order to get through the barriers
  # As a customer
  # I need to touch in and out
  it 'set to in journey when touched in' do
    card.top_up(10)
    card.touch_in
    expect(card).to be_in_journey
  end

  it 'sets to not in journey when touched out' do
    card.top_up(10)
    card.touch_in
    card.touch_out
    expect(card).not_to be_in_journey
  end
  # In order to pay for my journey
  # As a customer
  # I need to have the minimum amount for a single journey
  it 'raise error when balance below minimum on touch in' do
    expect{ card.touch_in }.to raise_error('Not enough balance for fare')
  end
  # In order to pay for my journey
  # As a customer
  # I need to pay for my journey when it's complete
  it 'pay for journey when touch out' do
    subject.top_up(10)
    expect{ subject.touch_out }.to change{ subject.balance }.by(-Oystercard::FARE)
  end
  # In order to pay for my journey
  # As a customer
  # I need to know where I've travelled from

  # In order to know where I have been
  # As a customer
  # I want to see to all my previous trips
  #
  # In order to know how far I have travelled
  # As a customer
  # I want to know what zone a station is in
  #
  # In order to be charged correctly
  # As a customer
  # I need a penalty charge deducted if I fail to touch in or out
  #
  # In order to be charged the correct amount
  # As a customer
  # I need to have the correct fare calculated
end
