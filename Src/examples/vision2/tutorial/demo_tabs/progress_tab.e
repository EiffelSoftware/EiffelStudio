indexing
	description: "Objects that ..."
	author: "Ian King"
	date: "$Date$"
	revision: "$Revision$"

class
	PROGRESS_TAB

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
			cmd1,cmd2: EV_ROUTINE_COMMAND
			h1: EV_HORIZONTAL_SEPARATOR
		once
			{ANY_TAB} Precursor (Void)
				
				-- Creates the objects and their commands

			create cmd1.make (~set_level)
			create cmd2.make (~get_level)
			create f1.make (Current, 0, 0, "Bar Level", cmd1, cmd2)

			create cmd2.make (~get_mode)
			create f2.make (Current, 1, 0, "Mode", Void, cmd2)
			create h1.make (Current)
			set_child_position (h1, 2, 0, 3, 3)

			create cmd1.make (~set_continuous)
			--create b1.make_with_text(Current, "Continuous Mode")
			create b1.make(Current)
			b1.set_text("Set to Continuous Mode")
			b1.set_vertical_resize(False)
			b1.add_click_command (cmd1, Void)
			set_child_position (b1, 3, 0, 4, 1)
			create cmd1.make (~set_segmented)
			--b2.make_with_text (Current, "Segmented Mode")
			create b2.make (Current)
			b2.set_text("Set to Segmented Mode")
			b2.set_vertical_resize (False)
			b2.add_click_command (cmd1, Void)
			set_child_position (b2, 3, 1, 4, 2)
	


			set_parent(par)
		end

feature -- Access
	
	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Progress"
		end


	set_level (arg:EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the level of the progress bar
		do
			current_widget.set_percentage(f1.get_text.to_integer)
		end

	get_level (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the level of the progress bar
		do
			f1.set_text(current_widget.value.out)
		end

	get_mode (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Is the mode of the progress bar continuous?
		do
			if current_widget.is_continuous then
				f2.set_text("Continuous")
			else
				f2.set_text("Segmented")
			end
		end

	set_continuous (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the mode of the progress bar to continuous.
		do
			current_widget.set_continuous
		end

	set_segmented (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the mode of the progress bar to segmented.
		do
			current_widget.set_segmented
		end

feature -- Execution feature



feature -- Access

	current_widget: EV_VERTICAL_PROGRESS_BAR

	f1,f2: TEXT_FEATURE_MODIFIER
	b1,b2: EV_BUTTON	
	
end -- class PROGRESS_TAB
 


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

