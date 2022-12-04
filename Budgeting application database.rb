require './sqlite_budget'

class BudgetingApp

  def initialize
    @expenses_hash = Hash.new
    print "Enter username: "
    @user_name = gets.chomp
    incomeTotal
    menu
  end 

  def incomeTotal
    user_budget = executeSelectQuery("expenses.db", "select * from budget where name = '#{@user_name}'")
    if user_budget == []
      print "Current income: £"
      income = gets.chomp.to_f
      executeQuery("expenses.db", "INSERT INTO budget ('name','budget_name','budget_value') 
        VALUES ('#{@user_name}','Income','#{income}')")
    end
  end

  def menu
    while true
      puts "\n"
      puts "Welcome #{@user_name}"
      puts "__________________________________________"
      puts "Type the number of the option you want"
      puts "__________________________________________"
      puts "1) Add expenses"
      puts "2) Update expenses"
      puts "3) Display current expenses"
      puts "4) Display current budgets"
      puts "5) Display remaining budget"
      puts "6) Exit"
      puts "__________________________________________"
      print ": "

      choice = gets.chomp
      case choice
        when "1"
          addExpenses
        when "2"
          updateExpense
        when "3"
          show_expense = executeSelectQuery("expenses.db", "select * from expense where name = '#{@user_name}'")
          show_expense.each {|expense| puts expense}
        when "4"
          show_budget = executeSelectQuery("expenses.db", "select * from budget where name = '#{@user_name}'")
          show_budget.each {|budget| puts budget}
        when "5"
          remainingBudget
        when "6"
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

  def addExpenses

    flag = true
    while flag
      print "Name of expense: "
      expense = gets.chomp.to_sym
      print "Value of expense: £"
      value = gets.chomp.to_f
      executeQuery("expenses.db", "INSERT INTO expense ('name','ex_name','ex_value') 
        VALUES ('#{@user_name}','#{expense}','#{value}')")
      #@total -= value
      flag = false if repeat
    end
    puts "New total: £#{@total}"
  end

  def updateExpense

    flag = true
    while flag
      print "Expense to update: "
      search = gets.chomp
      expense_search = executeSelectQuery("expenses.db", "SELECT * from expense where ex_name = '#{search}'")
      if expense_search != []
        print "New value: £"
        new_value = gets.chomp.to_f
        executeQuery("expenses.db", "UPDATE expense SET ex_value = '#{new_value}' where ex_name = '#{search}'")
        puts "Expense updated"
        puts "New total: £#{@total}"
      else 
        puts "Error: Expense not found"
      end
      flag = false if repeat
    end
  end

  #def remainingBudget

    #all_expense = executeSelectQuery("expenses.db", "SELECT ex_value from expense")
    #total = executeSelectQuery("expenses.db", "SELECT budget_value from budget where name = '#{@user_name}' and budget_name = 'Income'")
    #puts all_expense
    #puts total
    #final_total = all_expense.each {|expense| total -= expense}

  end
end

app = BudgetingApp.new