<?php

/**
 * Author: Simon Addicott
 * Date: 12/12/2022
 * 
 */

class BudgetingApp {

  private $total;
  private $expensesHash;
  private $userName;

  function __construct()
  {
    $this->login();
    $this->total = 0;
    $this->expensesHash = [];
    $this->getTotal();
    $this->menu();
  }

  function login()
  {
    system("clear");
    $this->userName = readline("Enter username: ");

    $this->expensesHash[$this->user_name] = $this->userName;
    
    $this->password = readLine("Enter password: ");
    
  }

  public function getTotal()
  {
    system("clear");
  	$this->total = readline("Current budget: £");
  }
  
  public function menu()
  {
    system("clear");
    while(true){
      system("clear");
      echo "\n";
      echo "Welcome " . $this->userName . "\n";
      echo "__________________________________________\n";
      echo "Type the number of the option you want\n";
      echo "__________________________________________\n";
      echo "1) Add expenses\n";
      echo "2) Update expenses\n";
      echo "3) Display current expenses\n";
      echo "4) Display remaining total\n";
      echo "5) Exit\n";
      echo "__________________________________________\n";

      $choice = readline(": ");
      switch($choice){
        case "1":
          $this->addExpenses();
          break;
        case "2":
          $this->updateExpense();
          break;
        case "3":
          system("clear");
          print_r($this->expensesHash) . "\n";
          readline("Press enter to continue...");
          break;
        case "4":
          system("clear");
          echo "Current total: £" . $this->total . "\n";
          readline("Press enter to continue...");
          break;
        case "5":
          break;
      }
    }
  }

  private function repeat()
  {
    echo "\n\n";
    $result = strtoupper(readLine('Repeat?: "Y" or "N"'));
    
    if ($result == "N")
      return true;
    
    return false;
  }

  private function addExpenses()
  {
    system("clear");
    $flag = true;
    while($flag){
      $expense = readline("Name of expense: ");
      $value = readline("Value of expense: £");
      $this->total -= $value;
      $this->expensesHash[$this->userName][$expense] = $value;

      if($this->repeat()){
        $flag = false;
      }

    }
    echo "New total: £" . $this->total . "\n";
  }

  private function updateExpense() 
  {
    system("clear");
    $flagg = true;
    while($flagg)
    {
      $search = readline("Expense to update: ");

      if(isset($this->expenses_hash[$search])){

        $newValue =  readline("New value: £");
        $oldValue = $this->expensesHash[$search];
        $diff = abs(($oldValue - $newValue));
        if ($newValue > $oldValue)
          $this->total -= $diff;
        else
          $this->total += $diff;
        
        $this->expenses_hash[$search] = $newValue;

        echo "Expense updated\n";
        echo  "New total: £" . $this->total . "\n";
      } else { 
        echo  "Error: Expense not found\n";
      }

      if($this->repeat()){
        $flagg = false;
      }

    }
  }
}

$app = new BudgetingApp();

?>