indexing
	description: "Class which is used to retrieve one of the objects of a query."
	author: "David Solal"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_ACTION_DYN

inherit
	ACTION
		redefine
			execute 
		end

create
	make

feature -- Creation
	
	make (s: like selection) is
			-- Initialize the selection 's'
		require
			not_void: s /= Void 
		do
			selection := s
			Create list.make
		ensure
			set: selection = s 
		end

feature -- Actions

	execute is
			-- Update item with current selected item in the container.
			-- This procedure is beeing executed for each row resulted of the query
			-- Thus, in that way, we create a linked_list DB_TUPLE
		local
			tuple: DB_TUPLE
		do
				-- The call to copy (selection.cursor) will execute the mapping from the
				-- database to the tuple
			Create tuple.copy (selection.cursor)
			list.extend(deep_clone(tuple))
		end

feature -- Access

	selection: DB_SELECTION
		-- Current selection

	list: LINKED_LIST [ DB_TUPLE ]
		-- Result List of the query.

end -- class DB_ACTION_DYN

