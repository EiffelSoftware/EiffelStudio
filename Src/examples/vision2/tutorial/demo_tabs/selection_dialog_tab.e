indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SELECTION_DIALOG_TAB

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
			
		do
		{ANY_TAB} Precursor (Void)

		set_parent (par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab.
		do
			Result:="Selection Dialog"
		ensure then
			result_exists: Result /= Void
		end

	current_widget: EV_LIST
		-- The current demo.

	f1: TEXT_FEATURE_MODIFIER
		--  A feature modifier for the action window.

	b1: EV_BUTTON
		-- A button for the action window.

feature -- Execution Feature

end -- class SELECTION_DIALOG_TAB

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

