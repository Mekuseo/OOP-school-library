#!/usr/bin/env ruby

require_relative 'person'
require_relative 'book'
require_relative 'rental'
require_relative 'app'

class Main
  attr_accessor :books, :people, :rentals

  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def list_books
    puts 'List of Books:'
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end
    puts '---'
  end

  def list_people
    puts 'List of People:'
    @people.each do |person|
      puts "ID: #{person.id}, Name: #{person.name}"
    end
    puts '---'
  end

  def create_person
    print "Enter the person's name: "
    name = gets.chomp
    print 'Is the person a Teacher or a Student? (T/S): '
    role = gets.chomp.downcase
    if role == 't'
      print "Enter the teacher's specialization: "
      specialization = gets.chomp
      person = Teacher.new(0, specialization, name)
    elsif role == 's'
      print "Enter the student's classroom: "
      classroom = gets.chomp
      person = Student.new(0, classroom, name)
    else
      puts 'Invalid role. Person creation failed.'
      return
    end
    @people << person
    puts 'Person created successfully!'
    puts '---'
  end

  def create_book
    print "Enter the book's title: "
    title = gets.chomp
    print "Enter the book's author: "
    author = gets.chomp
    book = Book.new(title, author)
    @books << book
    puts 'Book created successfully!'
    puts '---'
  end

  def create_rental
    print 'Enter the rental date: '
    date = gets.chomp
    list_books
    print "Enter the book's index to rent: "
    book_index = gets.chomp.to_i
    book = @books[book_index]
    list_people
    print "Enter the person's ID to assign the rental: "
    person_id = gets.chomp.to_i
    person = @people.find { |p| p.id == person_id }
    if book && person
      rental = Rental.new(date, book, person)
      @rentals << rental
      puts 'Rental created successfully!'
      puts '---'
    else
      puts 'Invalid book index or person ID. Rental creation failed.'
    end
  end

  def list_rentals_for_person
    print "Enter the person's ID to list rentals: "
    person_id = gets.chomp.to_i
    person = @people.find { |p| p.id == person_id }
    if person
      rentals = @rentals.select { |rental| rental.person == person }
      puts "Rentals for Person ID #{person_id}:"
      rentals.each do |rental|
        puts "Book: #{rental.book.title}, Author: #{rental.book.author}, Date: #{rental.date}"
      end
      puts '---'
    else
      puts 'Invalid person ID. Rental listing failed.'
    end
  end
end

def main
  app = App.new
  app.run
end

main if __FILE__ == $PROGRAM_NAME
