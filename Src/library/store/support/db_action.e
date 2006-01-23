indexing
	description: "Objects that redefine ACTION to store Eiffel objects converted %
		% from database in a list."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

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
	
	make (a_selection: like selection; an_item: G) is
			-- Initialize.
		require
			not_void: a_selection /= Void and an_item /= Void
		do
			selection := a_selection
			item := an_item
			create list.make (50)
		ensure
			set: selection = a_selection and item = an_item
		end

feature -- Actions

	execute is
			-- Update item with current
			-- selected item in the container.
		do
			selection.cursor_to_object
			list.extend (item.deep_twin)
		end

feature -- Access

	selection: DB_SELECTION
			-- Current selection.

	item: G
			-- Current found item in `selection'.
			-- Must be a reference on `selection.object',
			-- thus `selection.cursor_to_object' updates it.
			--| `selection.object' is not used directly to avoid
			--| reversed assignment/to have static type checking
			--| on `list'.

	list: ARRAYED_LIST [G];
			-- Result list.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DB_ACTION


