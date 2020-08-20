# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create! username: 'John Doe', email: 'john@gmail.com', handle: 'John', password: 'password', password_confirmation: 'password'
user = User.create! username: 'Tom Doe', email: 'tom@gmail.com', handle: 'Tom', password: 'password', password_confirmation: 'password'
user = User.create! username: 'Eric Doe', email: 'eric@gmail.com', handle: 'Eric', password: 'password', password_confirmation: 'password'
user = User.create! username: 'George Doe', email: 'george@gmail.com', handle: 'George', password: 'password', password_confirmation: 'password'
user = User.create! username: 'Will Doe', email: 'will@gmail.com', handle: 'Will', password: 'password', password_confirmation: 'password'
user = User.create! username: 'Dave Doe', email: 'dave@gmail.com', handle: 'Dave', password: 'password', password_confirmation: 'password'
