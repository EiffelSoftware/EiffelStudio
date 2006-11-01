indexing
	description:"Represent a list of CUSTOMER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	
class
	CUSTOMER_LIST
	
inherit
	COLLECTION_BASE

	ANY

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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- Class CUSTOMER_LIST
