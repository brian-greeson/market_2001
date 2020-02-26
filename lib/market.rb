require "./lib/item"
require "./lib/vendor"

class Market
  attr_reader :name
  
  def initialize(name)
    @name = name
  end

end
