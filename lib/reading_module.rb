require 'csv'

# base module for reading data for communication company
module ReadingModule
  def self.read_initial_subscribers(path)
    subscribers = []
    CSV.foreach(path, headers: true) do |row|
      subscribers.push(row.to_h)
    end
    subscribers
  end

  def self.save_subscribers; end
end
