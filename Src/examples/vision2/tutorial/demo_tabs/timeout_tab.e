indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TIMEOUT_TAB
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
				cmd2: EV_ROUTINE_COMMAND			
			do
				{ANY_TAB} Precursor (Void)
					-- Creates the objects and their commands.
				create cmd2.make (~period)
				create f1.make (Current, 0, 0, "Period", Void, cmd2)
				create cmd2.make (~count)
				create f2.make (Current, 1, 0, "Count", Void, cmd2)
				set_parent (par)
			end

feature -- Access

	name:STRING is
			-- Returns the name of the tab.
		do
			Result:="Timeout Tip"
		ensure then
			result_exists: Result /= Void
		end
	
	f1,f2: TEXT_FEATURE_MODIFIER
		-- Feature modifiers for the demo.

	current_widget: EV_TIMEOUT
		-- The current demo.

feature -- Execution Features
	
	period (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- period of `current widget'.
		do
			f1.set_text (current_widget.period.out)
		end

	count (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Number of times called.
		do
			f2.set_text (current_widget.count.out)
		end

end -- class TIMEOUT_TAB

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

