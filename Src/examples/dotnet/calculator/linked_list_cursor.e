indexing
	description: "Cursors for linked lists";
	status: "See notice at end of class";
	names: linked_list_cursor, cursor;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class LINKED_LIST_CURSOR [G]

create 
	make

feature {LINKED_LIST} -- Initialization

	make (active_element: like active; aft, bef: BOOLEAN) is
			-- Create a cursor and set it up on `active_element'.
		do
			active := active_element
			after := aft
			before := bef
		end;
	
feature {LINKED_STACK} -- Implementation

	active: LINKABLE [G]
			-- Current element in linked list

	after: BOOLEAN
			-- Is there no valid cursor position to the right of cursor?

	before: BOOLEAN
			-- Is there no valid cursor position to the right of cursor?
	
end -- class LINKED_LIST_CURSOR

