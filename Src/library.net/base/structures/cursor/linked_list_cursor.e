indexing
	description: "Cursors for linked lists"
	external_name: "ISE.Base.LinkedListCursor"

class
	LINKED_LIST_CURSOR [G]

inherit

	CURSOR

create

	make

feature {LINKED_LIST} -- Initialization

	make (active_element: like active; aft, bef: BOOLEAN) is
		indexing
			description: "Create a cursor and set it up on `active_element'."
		do
			active := active_element
			after := aft
			before := bef
		end

feature {LINKED_LIST} -- Implementation

	active: LINKABLE [G]
		indexing
			description: "Current element in linked list"
		end

	after: BOOLEAN
		indexing
			description: "Is there no valid cursor position to the right of cursor?"
		end

	before: BOOLEAN
		indexing
			description: "Is there no valid cursor position to the right of cursor?"
		end

invariant
	not_both: not (before and after)
	no_active_not_on: active = Void implies (before or after)

end -- class LINKED_LIST_CURSOR
