# Sqlite is used to store user information
require './sqlite_budget'

# Our application class
class BudgetingApp

  def initialize
    #Ask for username, run total and menu
    print "Enter username: "
    @user_name = gets.chomp
    incomeTotal
    menu
  end 

  def incomeTotal
    # Gets income budget unless user has already declared a budget
    user_budget = executeSelectQuery("expenses.db", "select * from budget where name = '#{@user_name}'")
    if user_budget == []
      print "Current income: £"
      income = gets.chomp.to_f
      executeQuery("expenses.db", "INSERT INTO budget ('name','budget_name','budget_value') 
        VALUES ('#{@user_name}','Income','#{income}')")
    end
  end

  def menu
    # Menu function is used to access the functions of the app
    while true
      puts "\n"
      puts "Welcome #{@user_name}"
      puts "__________________________________________"
      puts "Type the number of the option you want"
      puts "__________________________________________"
      puts "1) Add expenses"
      puts "2) Update expenses"
      puts "3) Display current expenses"
      puts "4) Delete expense"
      puts "5) Display current budgets"
      puts "6) Display remaining budget"
      puts "7) Exit"
      puts "__________________________________________"
      print ": "

      choice = gets.chomp
      case choice
        # Case is used for multiple options
        when "1"
          clear
          addExpenses
        when "2"
          clear
          updateExpense
        when "3"
          clear
          # Code block returns all expenses in expense database and the total of the expenses
          show_expense = executeSelectQuery("expenses.db", "select * from expense where name = '#{@user_name}'")
          show_expense.each {|expense| puts "#{expense["ex_name"]}: £#{expense["ex_value"]}"}
          all_expense = executeSelectQuery("expenses.db", "SELECT SUM(ex_value) FROM expense where name = '#{@user_name}'")
          all_expense.each {|total| puts "Total: £#{total["SUM(ex_value)"]}"}
        when "4"
          clear
          delExpense
        when "5"
          clear
          # Code block returns all budgets from budget database
          show_budget = executeSelectQuery("expenses.db", "select * from budget where name = '#{@user_name}'")
          show_budget.each {|budget| puts "#{budget["budget_name"]}: £#{budget["budget_value"]}"}
        when "6"
          clear
          remainingBudget
        when "7"
          clear
          break
      end
    end
  end

  def repeat
    # Repeat function so user can repeat functions
    puts 'Repeat?: "Y" or "N"'
    result = gets.chomp.upcase
    if result[0] == "N"
      return true
    else
      return false
    end
  end

  def clear
    # Clears the screen
      system("clear") || system("cls")
  end

  def addExpenses
    # This function takes input and adds to a database
    flag = true
    while flag
      print "Name of expense: "
      expense = gets.chomp.to_sym
      print "Value of expense: £"
      value = gets.chomp.to_f
      executeQuery("expenses.db", "INSERT INTO expense ('name','ex_name','ex_value') 
        VALUES ('#{@user_name}','#{expense}','#{value}')")
      flag = false if repeat
    end
    puts "New total: £#{@total}"
  end

  def delExpense
     # Takes input and deletes expense if found
     flag = true
     while flag
        print "Expense to delete: "
        search = gets.chomp
        expense_search = executeSelectQuery("expenses.db", "SELECT * from expense where ex_name = '#{search}'")
      # Will only continue if the search returns an array with a vlue
      if expense_search != []
        executeQuery("expenses.db", "DELETE from expense WHERE ex_name = '#{search}'")
        puts "Expense deleted"
      else
        puts "Error: Expense not found"
      end
      flag = false if repeat
    end
  end

  def updateExpense
    # Takes input and searches expense database to update value
    flag = true
    while flag
      print "Expense to update: "
      search = gets.chomp
      expense_search = executeSelectQuery("expenses.db", "SELECT * from expense where ex_name = '#{search}'")
      # Will only continue if the search returns an array with a vlue
      if expense_search != []
        print "New value: £"
        new_value = gets.chomp.to_f
        executeQuery("expenses.db", "UPDATE expense SET ex_value = '#{new_value}' where ex_name = '#{search}'")
        puts "Expense updated"
      else 
        puts "Error: Expense not found"
      end
      flag = false if repeat
    end
  end

  def remainingBudget
    # Subtracts the total of all expense database from income 
    all_expense = executeSelectQuery("expenses.db", "SELECT SUM(ex_value) FROM expense where name = '#{@user_name}'")
    total = executeSelectQuery("expenses.db", "SELECT budget_value from budget where name = '#{@user_name}' and budget_name = 'Income'")
    final_total = total[0]["budget_value"] - all_expense[0]["SUM(ex_value)"]
    puts "Remaining budget: £#{final_total.round(2)}"
  end
end

app = BudgetingApp.new