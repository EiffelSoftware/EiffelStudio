indexing
	description: "Cursors for arrayed lists"
	external_name: "ISE.Base.ArrayedListCursor"

class
	ARRAYED_LIST_CURSOR
	
inherit

	CURSOR

create
	make

feature {ARRAYED_LIST, BINARY_TREE} -- Initialization

	make (current_index: INTEGER) is
		indexing
			description: "Create a cursor and set it up on `current_index'."
		do
			index := current_index
		end

feature {ARRAYED_LIST, BINARY_TREE} -- Access

	index: INTEGER
		indexing
			description: "Index of current item"
		end

end -- class ARRAYED_LIST_CURSOR
