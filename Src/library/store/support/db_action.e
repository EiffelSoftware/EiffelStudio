indexing
	description: "Objects that redefine ACTION to store Eiffel objects converted %
		% from database in a list."
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
			list.extend (deep_clone (item))
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

	list: ARRAYED_LIST [G]
			-- Result list.

end -- class DB_ACTION

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
