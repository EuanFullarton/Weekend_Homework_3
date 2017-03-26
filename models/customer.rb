require_relative('../db/sql_runner')
require_relative('film')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ('#{@name}', #{@funds}) RETURNING *"
    customer = SqlRunner.run(sql).first()
    @id = customer['id'].to_i
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ('#{@name}', #{@funds}) WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def films()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON tickets.film_id = films.id WHERE tickets.customer_id = #{@id}"
    return Film.map_items(sql)
  end

  def number_of_tickets()
    sql = "SELECT tickets.* FROM tickets WHERE tickets.customer_id = #{@id}"
    tickets = Ticket.map_items(sql)
    return tickets.length()
  end

  def buy_tickets()
    customer_funds = @funds
    sql = "SELECT films.price FROM films INNER JOIN tickets ON tickets.film_id = films.id WHERE tickets.customer_id = #{@id}"
    film_price = SqlRunner.run(sql).first['price'].to_i
    if customer_funds >= film_price
      @new_total = (customer_funds - (film_price * number_of_tickets)).to_i
      sql = "UPDATE customers SET (funds) = (#{@new_total}) WHERE id = #{@id}"
      SqlRunner.run(sql)
      @funds = @new_total
      return "New total for #{@name} is #{@new_total}"
    else
      return "#{@name} can't afford this ticket."
    end
  end

  def self.all()
    sql = "SELECT * FROM customers"
    return Customer.map_items(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.map_items(sql)
    customers = SqlRunner.run(sql)
    result = customers.map {|customer| Customer.new(customer)}
    return result
  end
end