require_relative File.expand_path('reading_module.rb', __dir__)
require_relative File.expand_path('subscriber.rb', __dir__)

# base class of communication company
class Company
  def initialize(path)
    @subscribers = []

    if path
      initial_subscribers = ReadingModule.read_initial_subscribers(path)
      @subscribers += initial_subscribers
    end

    @subscribers = @subscribers.map { |sub| Subscriber.new(sub) }
  end

  def find_subscriber_by_name(sub)
    subs = @subscribers.select do |subscriber|
      subscriber.first_name == sub['firstName'] &&
        subscriber.last_name == sub['lastName']
    end
    result = ''
    subs.each { |sub_c| result += sub_c.to_s + "\n" }
    return false if result == ''

    result
  end

  def free_number
    numbers = Hash.new(false)
    @subscribers.each { |sub_c| numbers[sub_c.number] = true }

    i = 100_000
    while i < 1_000_000
      break unless numbers[i]

      i += 1
    end
    i
  end

  def add_subscriber(sub)
    i = free_number

    if i == 1_000_000
      puts 'Company full'
    else
      sub['number'] = i
      @subscribers.push(Subscriber.new(sub))
      return i
    end
  end

  def delete_subscriber(sub_h)
    @subscribers.delete_if do |sub|
      sub.first_name == sub_h['firstName'] && sub.last_name == sub_h['lastName']
    end
  end

  def find_subscriber_by_number(num)
    sub = @subscribers.find { |sub_c| sub_c.number == num }
    return sub.to_s if sub

    'Company hasn\'t subscriber with such number'
  end

  def all_subscribers
    result = ''
    @subscribers.each do |sub|
      result += sub.to_s + "\n"
    end

    return 'Company has no subscribers' if result == ''

    result
  end

  def calc_2_tarif(mins)
    return 300 if mins <= 350

    300 + (mins - 350) * 0.34
  end

  def calc_receipt(num, mins)
    sub = @subscribers.find { |sub_c| sub_c.number == num }
    case sub.tarif
    when 1
      return 'You have to paid 420'
    when 2
      cost = calc_2_tarif(mins)
    when 3
      cost = mins * 0.38 + 180
    end
    "You have to paid #{cost}"
  end

  def get_subscribers_by_tarif(tarif)
    subs = @subscribers.select do |subscriber|
      subscriber.tarif == tarif
    end
    result = ''
    subs.each { |sub| result += sub.to_s + "\n" }
    return 'No subscribers with such tarif' if result == ''

    result
  end
  attr_reader :subscribers
end
