note
	description: "Summary description for {SHOPPING_BILLS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHOPPING_BILLS

inherit
	ITERABLE [SHOPPING_BILL]

create
	make

feature {NONE} -- Initialization

	make (nb: INTEGER)
		do
			create items.make (nb)
		end

feature -- Access

	items: ARRAYED_LIST [SHOPPING_BILL]

feature -- Access

	new_cursor: ITERATION_CURSOR [SHOPPING_BILL]
			-- Fresh cursor associated with current structure
		do
			Result := items.new_cursor
		end

end
