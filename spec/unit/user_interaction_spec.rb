require 'user_interaction'
require 'company'

RSpec.describe UserInteraction do
  include UserInteraction
  before do
    allow($stdout).to receive(:puts)
    @company = UserInteraction.company
  end

  describe '#read_full_name' do
    it 'input' do
      expect($stdin).to receive(:gets).and_return('first', 'name')
      expect(UserInteraction.read_full_name).to eq('firstName' => 'first', 'lastName' => 'name')
    end
  end

  describe '#read_tarif' do
    it 'right' do
      expect($stdin).to receive(:gets).and_return('3')
      expect(UserInteraction.read_tarif).to eq(3)
    end
    it 'right after wrong' do
      expect($stdin).to receive(:gets).and_return('lol')
      expect($stdin).to receive(:gets).and_return('3')
      expect(UserInteraction.read_tarif).to eq(3)
    end
  end

  describe '#read_number' do
    it 'right' do
      expect($stdin).to receive(:gets).and_return('123456')
      expect(UserInteraction.read_number).to eq(123_456)
    end

    it 'right after wrong' do
      expect($stdin).to receive(:gets).and_return('12345')
      expect($stdin).to receive(:gets).and_return('123456')
      expect(UserInteraction.read_number).to eq(123_456)
    end
  end

  describe '#read_minutes' do
    it 'right' do
      expect($stdin).to receive(:gets).and_return('123456')
      expect(UserInteraction.read_minutes).to eq(123_456)
    end

    it 'right after wrong' do
      expect($stdin).to receive(:gets).and_return('-123456')
      expect($stdin).to receive(:gets).and_return('123456')
      expect(UserInteraction.read_minutes).to eq(123_456)
    end
  end

  describe '#add_subscriber' do
    it 'add subscriber' do
      @subscriber = { 'firstName' => 'first', 'lastName' => 'last' }
      expect($stdin).to receive(:gets).and_return('first', 'last', '3')
      expect(@company).to receive(:add_subscriber)
      UserInteraction.add_subscriber
    end
  end

  describe '#delete_subscriber' do
    it 'delete_subscriber' do
      expect($stdin).to receive(:gets).and_return('first', 'user')
      expect(@company).to receive(:delete_subscriber)
      UserInteraction.delete_subscriber
    end
  end

  describe '#find_subscriber' do
    it 'by name' do
      expect($stdin).to receive(:gets).and_return('1', 'first', 'user')
      expect(@company).to receive(:find_subscriber_by_name)
      UserInteraction.find_subscriber
    end

    it 'by num' do
      expect($stdin).to receive(:gets).and_return('2', '123456')
      expect(@company).to receive(:find_subscriber_by_number)
      UserInteraction.find_subscriber
    end
  end

  describe '#show_subscribers' do
    it 'all subscribers' do
      expect(@company).to receive(:all_subscribers)
      UserInteraction.show_subscribers
    end
  end

  describe '#show_receipt' do
    it 'calc_receipt' do
      expect($stdin).to receive(:gets).and_return('123456', '2')
      expect(@company).to receive(:calc_receipt)
      UserInteraction.show_receipt
    end
  end

  describe '#show_subscribers_by_tarif' do
    it 'show_subscribers_by_tarif' do
      expect($stdin).to receive(:gets).and_return('3')
      expect(@company).to receive(:get_subscribers_by_tarif)

      UserInteraction.show_subscribers_by_tarif
    end
  end
end
