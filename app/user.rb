class User
  attr_accessor :id
  attr_reader :name, :credit

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @credit = attributes[:credit] || 0
  end

  def update_balance(amount)
    @credit += amount
  end

  def attributes
    [:id, :name, :credit]
  end

  def values
    attributes.map { |attr| self.send(attr) }
  end

  def description
    "#{@name} (#{@credit})"
  end
end
