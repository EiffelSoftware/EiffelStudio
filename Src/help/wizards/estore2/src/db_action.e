indexing
	description: "Class which is used to retrieve objects."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_ACTION [G]

inherit
	ACTION
		redefine
			execute 
		end

create
	make

feature -- Creation
	
	make (s: like selection;an_item: G) is
			-- Initialize
		require
			not_void: s /= Void and an_item /= Void
		do
			selection := s
			item := an_item
			create list.make (50)
		ensure
			set: selection = s and item = an_item
		end

feature -- Actions

	execute is
			-- Update item with current
			-- selected item in the container.
		do
			selection.cursor_to_object
			list.extend (deep_clone (item))
		end

feature -- Access

	selection: DB_SELECTION
		-- Current selection

	item: G
		-- Current found item.

	list: ARRAYED_LIST [G]
		-- Result List.

end -- class DB_ACTION
