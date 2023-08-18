class IntentSearchService

  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def search_intents
    intents = {}

    intents[:name] = find_name
    intents[:destination] = find_destination
    intents[:work] = find_work
    intents[:time] = find_time

    { response: intents }
  end

  private

  def find_name
    @data.match(/My name is (\w+)/)&.captures&.first
  end

  def find_destination
    @data.match(/fly to (\w+)/)&.captures&.first
  end

  def find_work
    @data.match(/work as an (\w+)/)&.captures&.first
  end

  def find_time
    @data.match(/at (\d{1,2}:\d{2})/)&.captures&.first
  end
end
