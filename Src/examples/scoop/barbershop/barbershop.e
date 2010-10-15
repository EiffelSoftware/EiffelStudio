indexing
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

	make is
			-- Creation procedure.
			local
				i: INTEGER -- loop iterator
				a_customer: separate CUSTOMER
				l_sep_customer: SEP_CUSTOMER
			do
				create shop.make (number_of_chairs)
				create barber.make (shop, time_for_hair_cut)

				create customers.make(1, number_of_customers)

				from
					i := 1
				until
					i > number_of_customers
				loop
					create a_customer.make (i, barber, shop, number_of_haircuts)
					create l_sep_customer.make (a_customer)
					customers.put(l_sep_customer, i)
					i := i + 1
				end

				from
					i := 1
				until
					i > number_of_customers
				loop
					launch_customer ((customers @ i).customer)
					i := i + 1
				end
			end


feature {NONE} -- Implementation

	number_of_customers: INTEGER is 30
	number_of_chairs: INTEGER is 8
	number_of_haircuts: INTEGER is 3 -- how many times each customer wants to get hair cut
	time_for_hair_cut: INTEGER is 1000

	barber: separate BARBER
	shop: separate SHOP

	customers: ARRAY [SEP_CUSTOMER]

	launch_customer (a_customer: separate CUSTOMER) is
			-- launch customer in a controlled manner
			do
				a_customer.live
			end

end -- class APPLICATION
