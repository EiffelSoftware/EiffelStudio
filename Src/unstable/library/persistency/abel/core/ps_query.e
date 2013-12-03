note
	description: "Represents a query for objects of type OBJECT_TYPE."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_QUERY [OBJECT_TYPE -> ANY]

inherit
	PS_ABSTRACT_QUERY [OBJECT_TYPE, OBJECT_TYPE]

create
	make, make_with_criterion

feature -- Status report

	is_tuple_query: BOOLEAN = False
			-- Is `Current' an instance of PS_TUPLE_QUERY?

feature {PS_ABEL_EXPORT} -- Implementation: Element change

	retrieve_next
			-- Retrieve the next item from the database and store it in `result_cache'.
		do
			internal_transaction.repository.next_entry (Current)
		end

end
