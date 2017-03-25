require ('pry')
require_relative ('models/customer')
require_relative ('models/film')
require_relative ('models/ticket')


customer1 = Customer.new({'name' => 'Percy', 'funds' => 10})
customer2 = Customer.new({'name' => 'Agnes', 'funds' => 6})
customer3 = Customer.new({'name' => 'Tyrone', 'funds' => 8})
customer4 = Customer.new({'name' => 'Jim', 'funds' => 5})
customer1.save()
customer2.save()
customer3.save()
customer4.save()


film1 = Film.new({'title' => 'Goodfellas', 'price' => 5})
film2 = Film.new({'title' => 'The Godfather', 'price' => 4})
film3 = Film.new({'title' => 'The Departed', 'price' => 7})
film1.save()
film2.save()
film3.save()

ticket1 = Ticket.new({"customer_id" => customer1.id, "film_id" => film1.id})
ticket2 = Ticket.new({"customer_id" => customer2.id, "film_id" => film1.id})
ticket3 = Ticket.new({"customer_id" => customer3.id, "film_id" => film3.id})
ticket4 = Ticket.new({"customer_id" => customer4.id, "film_id" => film2.id})
ticket5 = Ticket.new({"customer_id" => customer4.id, "film_id" => film2.id})
ticket6 = Ticket.new({"customer_id" => customer4.id, "film_id" => film1.id})
ticket7 = Ticket.new({"customer_id" => customer4.id, "film_id" => film1.id})
ticket8 = Ticket.new({"customer_id" => customer1.id, "film_id" => film3.id})
ticket9 = Ticket.new({"customer_id" => customer3.id, "film_id" => film1.id})
ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()
ticket5.save()
ticket6.save()
ticket7.save()
ticket8.save()
ticket9.save()

binding.pry
nil