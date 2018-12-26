require 'subscriber'

RSpec.describe Subscriber do
  describe '#to_s' do
    it 'show subscriber info' do
      subscriber = Subscriber.new('firstName' => 'Ivan', 'lastName' => 'Petrov', 'tarif' => '3', 'number' => '123456')
      expect(subscriber.to_s).to eq("Subscriber:\nIvan Petrov, tarif: 3, num: 123456")
    end
  end
end
