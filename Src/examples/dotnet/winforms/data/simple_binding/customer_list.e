indexing
	description:"Represent a list of CUSTOMER"
	
class
	CUSTOMER_LIST


create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `customers'.
		local
			l_customer: CUSTOMER
		do
			create customers.make
--			create l_customer.make_with_data ("1", "M", "Neil", "AMSTRONG", "15 ", create {SYSTEM_DATE_TIME}.make_from_year_and_month_and_day (2002, 01, 01))
			customers.extend (l_customer)
--			create l_customer.make_with_data ("2", "M", "Mickael", "JORDAN", "15 ", make_from_year_and_month_and_day (1979, 11, 25))
			customers.extend (l_customer)
		ensure
			non_void_customers: customers /= Void
		end


feature -- Access

	customers: LINKED_LIST [CUSTOMER]
	

feature -- Basic Operations

	count: INTEGER is
			-- count
		do
			Result := customers.count
		ensure
			positiv_result: Result >= 0
		end
		

end -- Class CUSTOMER_LIST