# There are four high-level responsibilities, each of which have multiple sub-responsibilities:
# 1. Gathering user input and taking the appropriate action (controller)
# 2. Displaying information to the user (view)
# 3. Reading and writing from the todo.txt file (model)
# 4. Manipulating the in-memory objects that model a real-life TODO list (domain-specific model)

# Note that (4) is where the essence of your application lives.
# Pretty much every application in the universe has some version of responsibilities (1), (2), and (3).

require 'csv'

class List 
  attr_reader :todo_list 
  def initialize
    @todo_list = []
  end

  def load_file(filename)
    CSV.foreach(filename) do |row|
      todo_list << Tasks.new(row[0])      
    end 
    todo_list
  end

  def delete(task_index)
    todo_list.delete_at(task_index)
  end

  def add(task)
    todo_list <<  Tasks.new(task)
  end

  def print_all
    i = 0
    
    length = todo_list.length 
    while i < length 
      task = todo_list[i]
      puts "#{i+1}. #{mark_complete(task.complete?)} #{task.todo}" 
      i += 1
    end   
  end

  def complete_task(id)
    task[id].complete = true 
  end

  def save
    #write to csv to save the state of completion 
    CSV.foreach(filename, "w")  do |row|
      csv << Tasks.new(row[0]).mark_complete()    
    end 
  end


  private

  def mark_complete(boolean)
    (boolean) ? "[X]" : "[ ]"
  end

end 

class Tasks 
  attr_reader :todo

  def initialize(complete, todo)
    @todo = todo
    @complete = complete
  end

  def complete? 
    @complete
  end

end 

if ARGV.any? 
  list = List.new
  list.load_file('todo.csv')
  if ARGV[0] == "list"
    list.print_all  
  elsif ARGV[0] == "add"
    list.add(ARGV[1])
    puts "Appended #{ARGV[1]} to your TODO list..." 
  elsif ARGV[0] == "delete" 
    list.delete(ARGV[1].to_i) 
    puts "Deleted #{ARGV[1]} from your TODO list..."
  elsif ARGV[0] == "done" 
    list.complete_task(ARGV[1].to_i)  
    puts "Deleted #{ARGV[1]} from your TODO list..."    
  end
end


# task = Tasks.new('Move with Lil to the black mountain hills of Dakota')
  list = List.new
  p list.load_file('todo.csv')
# p list.add('Visit doctor')
 # p list.print_all
 # list.check(3)
 # list.print_all
# p list.todo_list.length
# p list.delete(0)
# p list.todo_list.length