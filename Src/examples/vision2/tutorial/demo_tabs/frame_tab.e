indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FRAME_TAB

inherit
	ANY_TAB
		redefine
			make,
			current_widget
		end

creation
	make

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the tab and initialise objects.
		local
			cmd1, cmd2: EV_ROUTINE_COMMAND
		do
			{ANY_TAB} Precursor (Void)
				
			-- Creates the objects and their commands
			create cmd1.make (~set_text1)
			create cmd2.make (~get_text1)
			create f1.make (Current, 0, 0, "Frame Text", cmd1, cmd2)

			set_parent(par)
		end

feature -- Access
	
	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Frame"
		end

	current_widget: EV_FRAME
			-- Current widget we are working on.

	f1: TEXT_FEATURE_MODIFIER
			-- A modifier

feature -- Execution feature

	set_text1 (arg:EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the text of the frame
		do
			current_widget.set_text(f1.get_text)
		end

	get_text1 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the text of the frame
		do
			f1.set_text(current_widget.text)
		end
	

	

end -- class FRAME_TAB

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

