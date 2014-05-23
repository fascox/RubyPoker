class Testclass

		@x = 10
		def self.hello
			puts "hello world"
		end

end


# Testclass.hello
# Testclass.x
#
# t = Testclass.new
# puts t.x

# t.hello

# def calculate_tax(income)
# 	tax_rate = 0.2
# 	yield income * tax_rate
# end
#
# income = 60000
# net_income = income
#
# calculate_tax(income) do |tax|
# 	puts "You owe #{tax}."
# 	net_income -= tax
# end
#
# puts "Your net income: #{net_income}"


def total(prices)
	amount = 0
	do_something_with_every_item(prices) do |price|
		amount += price
	end
	return amount
end

def do_something_with_every_item(array)
	index = 0
	while index < array.length
		yield array[index]
		index += 1
	end
end

order = [3, 24, 6]
puts total(order)