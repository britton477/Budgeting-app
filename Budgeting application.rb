class BudgetingApp

  def initialize
    puts "Enter username: "
    @name = gets.chomp
    @total = 0
    @expenses_hash = Hash.new
    get_total
    menu

  end

  def get_total
  	print "Current budget: £"
  	@total = gets.chomp.to_i
  end
  
  def menu
    while true
      puts "\n"
      puts "Welcome #{@name}"
      puts "__________________________________________"
      puts "Type the number of the option you want"
      puts "__________________________________________"
      puts "1) Add expenses"
      puts "2) Update expenses"
      puts "3) Display current expenses"
      puts "4) Display remaining total"
      puts "5) Exit"
      puts "__________________________________________"
      print ": "

      choice = gets.chomp
      case choice
        when "1"
          add_expenses
        when "2"
          update_expense
        when "3"
          puts @expenses_hash
        when "4"
          puts "Current total: #{@total}\n"
        when "5"
          break
      end
    end
  end

  def repeat
    puts 'Repeat?: "Y" or "N"'
    result = gets.chomp.upcase
    if result[0] == "N"
      return true
    else
      return false
    end
  end

  def add_expenses

    flag = true
    while flag
      print "Name of expense: "
      expense = gets.chomp.to_sym
      print "Value of expense: £"
      value = gets.chomp.to_i
      @total -= value
      @expenses_hash[expense] = value

      flag = false if repeat
    end
    puts "New total: £#{@total}"
  end

  def update_expense

    flag = true
    while flag
      print "Expense to update: "
      search = gets.chomp.to_sym
      if @expenses_hash[search] != nil
        print "New value: £"
        new_value = gets.chomp.to_i
        old_value = @expenses_hash[search]
        diff = (old_value - new_value).abs
        if new_value > old_value
          @total -= diff
        else
          @total += diff
        end
        @expenses_hash[search] = new_value
        puts "Expense updated"
        puts "New total: £#{@total}"
      else 
        puts "Error: Expense not found"
      end
      flag = false if repeat
    end
  end
end

app = BudgetingApp.new

