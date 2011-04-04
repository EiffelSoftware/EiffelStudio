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
			-- Setup and execute example.
		local
			a_customer: separate CUSTOMER
			a_customer_list: ARRAYED_LIST [separate CUSTOMER]
		do
			create shop.make (number_of_chairs)
			create barber.make (time_for_haircut)

			create a_customer_list.make (number_of_customers)

			across (1 |..| number_of_customers) as ic loop
				create a_customer.make (ic.item, barber, shop, number_of_haircuts)
				a_customer_list.extend (a_customer)
			end

			across a_customer_list as ic loop launch_customer (ic.item) end

		end

feature {NONE} -- Implementation

	number_of_customers: INTEGER = 30
			-- Customer count.

	number_of_chairs: INTEGER = 8
			-- Chair count.

	number_of_haircuts: INTEGER = 3
			-- Haircut count per customer.

	time_for_haircut: INTEGER = 1000
			-- Duration of haircut.

	barber: separate BARBER
			-- Barber

	shop: separate SHOP
			-- Shop

	launch_customer (a_customer: separate CUSTOMER)
			-- Start `a_customer's life.
		do
			a_customer.live
		end

end
