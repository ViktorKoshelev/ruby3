require_relative File.expand_path('company.rb', __dir__)

# base module for interaction with user
module UserInteraction
  class << self
    attr_accessor :company
  end
  @company = Company.new('./lib/subscribers.csv')

  def self.main_menu
    print_menu_actions
    choose_action input_action
  end

  def self.print_menu_actions
    puts '-----------Choose action-----------'
    puts '[1] Add subscriber'
    puts '[2] Remove subscriber'
    puts '[3] Find subscriber by number or name'
    puts '[4] Show subscribers'
    puts '[5] Show receipt'
    puts '[6] Show subscribers by tarif'
    puts '[7] Exit'
  end

  def self.choose_action(action)
    exit if action.nil?
    case action.to_i
    when 1
      add_subscriber
    when 2
      delete_subscriber
    when 3
      find_subscriber
    when 4
      show_subscribers
    when 5
      show_receipt
    when 6
      show_subscribers_by_tarif
    when 7
      exit
    else
      puts 'Error!'
      puts 'Enter another action'
    end
    main_menu
  end

  def self.input_action
    $stdin.gets
  end

  def self.add_subscriber
    subscriber = read_full_name

    subscriber['tarif'] = read_tarif
    number = @company.add_subscriber(subscriber)
    puts "Your number is #{number}" if number
  end

  def self.read_full_name
    subscriber = {}
    subscriber['firstName'] = read_string('Enter first name').delete_suffix("\n")
    subscriber['lastName'] = read_string('Enter last name').delete_suffix("\n")
    subscriber
  end

  def self.read_string(message)
    puts message
    input_action
  end

  def self.read_tarif
    show_tarifs
    action = input_action.to_i
    return action if [1, 2, 3].include?(action)

    puts 'Error!'
    puts 'Wrong tarif!'
    read_tarif
  end

  def self.show_tarifs
    puts '[1] No limit'
    puts '[2] Combined'
    puts '[3] By time'
  end

  def self.delete_subscriber
    subscriber = read_full_name
    if @company.find_subscriber_by_name(subscriber)
      @company.delete_subscriber(subscriber)
    else
      puts 'Error! Subscriber not found!'
    end
  end

  def self.find_subscriber
    show_variants
    action = input_action.to_i
    if [1, 2].include?(action)
      return find_by_name if action == 1
      return find_by_number if action == 2
    else
      puts 'Error!'
      puts 'Wrong option!'
      return find_subscriber
    end
  end

  def self.show_variants
    puts '[1] By name'
    puts '[2] By number'
  end

  def self.find_by_name
    subscriber = read_full_name
    subscribers = @company.find_subscriber_by_name(subscriber)
    return puts subscribers if subscribers

    puts 'No one found'
  end

  def self.find_by_number
    number = read_number
    puts @company.find_subscriber_by_number(number)
  end

  def self.read_number
    puts 'Enter number ******'
    num = Integer(input_action)
    Integer('as') if (num < 100_000) || (num > 999_999)
    num
  rescue StandardError
    puts 'Please enter a number ******'
    read_number
  end

  def self.show_subscribers
    puts @company.all_subscribers
  end

  def self.show_receipt
    number = read_number
    puts @company.calc_receipt(number, read_minutes) if
      @company.find_subscriber_by_number(number)
  end

  def self.read_minutes
    puts 'Enter used minutes'
    mins = Integer(input_action)
    return mins if mins >= 0

    puts 'Used minutes can\'t be negative'
    read_minutes
  rescue StandardError
    puts 'Please enter a number, for example 100'
    read_minutes
  end

  def self.show_subscribers_by_tarif
    tarif = read_tarif
    puts @company.get_subscribers_by_tarif(tarif)
  end
end
