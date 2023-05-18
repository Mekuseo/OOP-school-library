require_relative 'main'

class App
  def initialize
    @main = Main.new
    @choices = {
      1 => :list_books,
      2 => :list_people,
      3 => :create_person,
      4 => :create_book,
      5 => :create_rental,
      6 => :list_rentals_for_person,
      7 => :quit
    }
  end

  def run
    loop do
      display_options
      choice = gets.chomp.to_i
      handle_choice(choice)
      break if choice == 7
    end
  end

  private

  def display_options
    puts 'Options:'
    puts '1. List all books'
    puts '2. List all people'
    puts '3. Create a person'
    puts '4. Create a book'
    puts '5. Create a rental'
    puts '6. List rentals for a person'
    puts '7. Quit'
    print 'Enter your choice: '
  end

  def handle_choice(choice)
    if @choices.key?(choice)
      send(@choices[choice])
    else
      puts 'Invalid choice. Please try again.'
    end
    puts '---'
  end

  def list_books
    @main.list_books
  end

  def list_people
    @main.list_people
  end

  def create_person
    @main.create_person
  end

  def create_book
    @main.create_book
  end

  def create_rental
    @main.create_rental
  end

  def list_rentals_for_person
    @main.list_rentals_for_person
  end

  def quit
    puts 'Exiting the application. Goodbye!'
  end
end

app = App.new
app.run
