indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ITEM_HOLDER_TAB

inherit
	ANY_TAB
		redefine
			make,
			current_widget
		end

creation
	make

feature -- Initialization

	make(par: EV_CONTAINER) is
			-- Create the tab and initalise the objects.
		local
			cmd1,cmd2: EV_ROUTINE_COMMAND
				-- Commands used by the tab.
			h1: EV_HORIZONTAL_SEPARATOR
		do
			{ANY_TAB} Precursor (Void)
			create cmd2.make (~count)
			create f1.make (Current, 0, 0, "Count", Void, cmd2)


			set_parent (par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab.
		do
			Result:="Item Holder"
		ensure then
			result_exists: Result /= Void
		end

	current_widget: EV_LIST
		-- The current demo.

	f1: TEXT_FEATURE_MODIFIER
		--  A feature modifier for the action window.

feature -- Execution Feature

	count (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Display `Count' objects held.
		do
			f1.set_text (current_widget.count.out)
		end

end -- class ITEM_HOLDER_TAB

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

