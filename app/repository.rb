require 'csv'

class Repository
  def initialize(model)
    @model = model
    @csv_file = "#{CSV_DIRECTORY}#{@model.to_s.downcase}s.csv"
    @csv_options = { headers: :first_row, header_converters: :symbol }

    @instances = []
    load_csv
    @next_id = @instances.empty? ? 0 : @instances.last.id + 1
  end

  def all
    @instances
  end

  def jar
    @instances.map(&:credit).sum
  end

  def add(instance)
    instance.id = @next_id
    @next_id += 1
    @instances << instance
    save_csv
  end

  def delete(id)
    @instances.reject! { |i| i.id == id }
    save_csv
  end

  def load_csv
    CSV.foreach(@csv_file, @csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:credit] = row[:credit].to_i
      @instances << @model.new(row)
    end
  end

  def save_csv
    CSV.open(@csv_file, "wb") do |csv|
      csv << @instances.first.attributes
      @instances.each do |instance|
        csv << instance.values
      end
    end
  end
end
