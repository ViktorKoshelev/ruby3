require 'company'

RSpec.describe Company do
  before do
    @test_company = Company.new(File.expand_path('test_base.csv', __dir__))
    puts '1'
  end

  describe '#find_subscriber_by_name' do
    it 'subscribers found' do
      @existing = { 'firstName' => 'first', 'lastName' => 'user' }
      @existing_to_s = "Subscriber:\nfirst user, tarif: 1, num: 123456\n"
      expect(@test_company.find_subscriber_by_name(@existing)).not_to be eq(false)
      expect(@test_company.find_subscriber_by_name(@existing)).to eq(@existing_to_s)
    end

    it 'subscribers not found' do
      @unreal1 = { 'firstName' => 'last', 'lastName' => 'user' }
      @unreal2 = { 'firstName' => 'first', 'lastName' => 'luser' }
      expect(@test_company.find_subscriber_by_name(@unreal1)).to eq(false)
      expect(@test_company.find_subscriber_by_name(@unreal2)).to eq(false)
    end
  end

  describe '#add_subscriber' do
    it 'subscriber added' do
      @adding = { 'firstName' => 'last', 'lastName' => 'user', 'tarif' => 3 }
      @added_number = 100_000
      expect(@test_company.add_subscriber(@adding)).to eq(@added_number)
    end
  end

  describe '#delete_subscriber' do
    it 'existing' do
      @existing = { 'firstName' => 'first', 'lastName' => 'user' }
      @test_company.delete_subscriber(@existing)
      expect(@test_company.subscribers.length).to eq(3)
    end

    it 'unexesting' do
      @unexesting = { 'firstName' => 'last', 'lastName' => 'user' }
      @test_company.delete_subscriber(@unexesting)
      expect(@test_company.subscribers.length).to eq(4)
    end
  end

  describe '#find_subscriber_by_number' do
    it 'existing' do
      @existing = 123_456
      @existing_to_s = "Subscriber:\nfirst user, tarif: 1, num: 123456"
      expect(@test_company.find_subscriber_by_number(@existing)).to eq(@existing_to_s)
    end

    it 'unexesting' do
      @unexesting = 100_000
      @error_text = 'Company hasn\'t subscriber with such number'
      expect(@test_company.find_subscriber_by_number(@unexesting)).to eq(@error_text)
    end
  end

  describe '#all_subscribers' do
    it 'have subscribers' do
      @result = "Subscriber:\n" \
        "first user, tarif: 1, num: 123456\n" \
        "Subscriber:\n" \
        "second user, tarif: 2, num: 123457\n" \
        "Subscriber:\n" \
        "third user, tarif: 2, num: 123458\n" \
        "Subscriber:\n" \
        "fourth user, tarif: 3, num: 123459\n"
      expect(@test_company.all_subscribers).to eq(@result)
    end

    it 'empty' do
      @company = Company.new(false)
      @result = 'Company has no subscribers'
      expect(@company.all_subscribers).to eq(@result)
    end
  end

  describe '#calc_receipt' do
    it 'no limit always pay 420' do
      @receipt = 'You have to paid 420'
      expect(@test_company.calc_receipt(123_456, 0)).to eq(@receipt)
    end

    it 'combined less 350 mins pay 300' do
      @receipt = 'You have to paid 300'
      expect(@test_company.calc_receipt(123_457, 40)).to eq(@receipt)
    end

    it 'combined more 350 mins' do
      @receipt = 'You have to paid 317.0'
      expect(@test_company.calc_receipt(123_457, 400)).to eq(@receipt)
    end

    it 'by time' do
      @receipt = 'You have to paid 218.0'
      expect(@test_company.calc_receipt(123_459, 100)).to eq(@receipt)
    end
  end

  describe '#get_subscribers_by_tarif' do
    it 'no limit' do
      @result = "Subscriber:\n" \
        "first user, tarif: 1, num: 123456\n"
      expect(@test_company.get_subscribers_by_tarif(1)).to eq(@result)
    end

    it 'combined' do
      @result = "Subscriber:\n" \
        "second user, tarif: 2, num: 123457\n" \
        "Subscriber:\n" \
        "third user, tarif: 2, num: 123458\n"
      expect(@test_company.get_subscribers_by_tarif(2)).to eq(@result)
    end

    it 'by time' do
      @result = "Subscriber:\n" \
        "fourth user, tarif: 3, num: 123459\n"
      expect(@test_company.get_subscribers_by_tarif(3)).to eq(@result)
    end
  end
end
