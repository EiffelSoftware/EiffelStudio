indexing
	description:"Represent a list of CUSTOMER"
	
class
	CUSTOMER_LIST
	
inherit
	COLLECTION_BASE

feature -- Initialization
		
	initialize is
			-- Initialize `customers'.
		local
			l_customer: CUSTOMER
			i: INTEGER
		do
			create l_customer.make_with_data ("1", "M", "Neil", "AMSTRONG", "15 ", create {SYSTEM_DATE_TIME}.make (2002, 01, 01))
			i := list.add (l_customer)
			create l_customer.make_with_data ("2", "M", "Mickael", "JORDAN", "15 ", create {SYSTEM_DATE_TIME}.make (1979, 11, 25))
			i := list.add (l_customer)
			create l_customer.make_with_data ("1", "M", "Neil Junior", "AMSTRONG", "15 ", create {SYSTEM_DATE_TIME}.make (2002, 01, 01))
			i := list.add (l_customer)
			create l_customer.make_with_data ("2", "M", "Mickael Junior", "JORDAN", "15 ", create {SYSTEM_DATE_TIME}.make (1979, 11, 25))
			i := list.add (l_customer)
			create l_customer.make_with_data ("1", "M", "Neil Senior", "AMSTRONG", "15 ", create {SYSTEM_DATE_TIME}.make (2002, 01, 01))
			i := list.add (l_customer)
			create l_customer.make_with_data ("2", "M", "Mickael Senior", "JORDAN", "15 ", create {SYSTEM_DATE_TIME}.make (1979, 11, 25))
			i := list.add (l_customer)
		end

end -- Class CUSTOMER_LIST