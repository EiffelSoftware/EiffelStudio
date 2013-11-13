note
	description: "Represents a query for objects of type OBJECT_TYPE."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_OBJECT_QUERY [OBJECT_TYPE -> ANY]

inherit
	PS_QUERY [OBJECT_TYPE, OBJECT_TYPE]

create
	make, make_with_criterion

feature -- Status report

	is_object_query: BOOLEAN = True
			-- Is `Current' an instance of PS_OBJECT_QUERY?

end
