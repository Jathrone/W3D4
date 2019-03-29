# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Poll.destroy_all
AnswerChoice.destroy_all
Response.destroy_all
Question.destroy_all


User.create(username: "Jared")
Poll.create(title: "What day is it?", user_id: User.find_by(username:"Jared").id)

Question.create(text: "And in what month?", poll_id: Poll.find_by(title:"What day is it?").id)
AnswerChoice.create(question_id: Question.find_by(text:"And in what month?").id, text: "March")
User.create(username: "Hamilton")
Response.create(user_id:User.find_by(username:"Hamilton").id, answer_choice_id:AnswerChoice.first.id)
Response.create(user_id:User.find_by(username:"Jared").id, answer_choice_id:AnswerChoice.first.id)