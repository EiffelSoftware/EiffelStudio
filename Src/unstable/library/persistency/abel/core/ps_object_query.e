note
	description: "[
	Represents a query for objects of type G.
	Objects of this type can be used directly to iterate through the query result.
	Example:
		across 
			my_query as cursor
		loop 
			-- do something with cursor.item 
		end
	]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_OBJECT_QUERY [G -> ANY]

inherit
	PS_QUERY [G, G]

create
	make, make_with_criterion

feature -- Status report

	is_object_query: BOOLEAN = True
			-- Is `Current' an instance of PS_OBJECT_QUERY?

end
