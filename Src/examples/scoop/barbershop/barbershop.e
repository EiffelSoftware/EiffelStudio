note
	description	: "System's root class"
	author		: "Robin Stoll"
	date		: "2009/5/16"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

class
	BARBERSHOP

create
	make

feature -- Initialization

	make
			-- Creation procedure.
		local
			i: INTEGER -- loop iterator
			a_customer: separate CUSTOMER
		do
			create shop.make (number_of_chairs)
			create barber.make (shop, time_for_hair_cut)

			create customers.make (number_of_customers)

			from
				i := 1
			until
				i > number_of_customers
			loop
				create a_customer.make (i, barber, shop, number_of_haircuts)
				customers.extend (a_customer)
				i := i + 1
			end

			from
				customers.start
			until
				customers.after
			loop
				launch_customer (customers.item)
				customers.forth
			end
		end

feature {NONE} -- Implementation

	number_of_customers: INTEGER = 30
	number_of_chairs: INTEGER = 8

	number_of_haircuts: INTEGER = 3
			-- How many times each customer wants to get hair cut?

	time_for_hair_cut: INTEGER = 1000

	barber: separate BARBER
	shop: separate SHOP

	customers: ARRAYED_LIST [separate CUSTOMER]

	launch_customer (a_customer: separate CUSTOMER)
			-- Launch customer in a controlled manner.
		do
			a_customer.live
		end

end
