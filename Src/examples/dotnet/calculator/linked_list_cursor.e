indexing
	description: "Cursors for linked lists"
	external_name: "ISE.Examples.Calculator.LinkedListCursor"

class 
	LINKED_LIST_CURSOR [G]

create 
	make

feature {LINKED_LIST} -- Initialization

	make (active_element: like active; aft, bef: BOOLEAN) is
		indexing
			description: "Create a cursor and set it up on `active_element'."
			external_name: "Make"
		require
			non_void_active_element: active_element /= Void
		do
			active := active_element
			after := aft
			before := bef
		ensure
			active_set: active = active_element
			after_set: after = aft
			before_set: before = bef
		end
	
feature {LINKED_STACK} -- Implementation

	active: LINKABLE [G]
		indexing
			description: "Current element in linked list"
			external_name: "Active"
		end

	after: BOOLEAN
		indexing
			description: "Is there no valid cursor position to the right of cursor?"
			external_name: "After"
		end

	before: BOOLEAN
		indexing
			description: "Is there no valid cursor position to the right of cursor?"
			external_name: "Before"
		end
	
end -- class LINKED_LIST_CURSOR