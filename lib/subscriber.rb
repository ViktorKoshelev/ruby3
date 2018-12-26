# base class of subscriber
class Subscriber
  def initialize(hash)
    @first_name = hash['firstName']
    @last_name = hash['lastName']
    @tarif = Integer(hash['tarif'])
    @number = Integer(hash['number'])
  end

  def to_s
    "Subscriber:\n" \
      "#{@first_name} #{last_name}, tarif: #{@tarif}, " \
      "num: #{@number}"
  end

  attr_reader :first_name, :last_name, :tarif, :number
end
