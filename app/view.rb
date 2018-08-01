class View
  def list(things)
    list_with_index(things) do |t, i|
      block_given? ? yield(t) : t
    end
  end

  def list_with_index(things)
    things.each_with_index { |t, i| puts block_given? ? yield(t, i) : "#{i + 1}. #{t}" }
    puts ""
    puts ""
  end

  def ask_for(thing)
    puts "Enter #{thing}:"
    input
  end

  def ask_amount(user, action)
    ask_for("amount that #{user.name} #{action} (if any)")
  end

  def jar(amount)
    puts "Money in jar: #{amount}"
    puts ""
    puts ""
  end

  def p(string)
    puts string
  end

  def welcome
    clear
    puts "Welcome to Casabalance!"
    puts "Created by Jeroen"
    puts "v1.0"
    puts ""
    puts ""
  end

  def header
    puts "~=+=+=+=+=  Casabalance  =+=+=+=+=~"
    puts ""
  end

  def input
    print "> "
    gets.chomp
  end

  def clear
    print `clear`
  end

  def invalid_action
    puts "Please enter a valid number"
  end
end
