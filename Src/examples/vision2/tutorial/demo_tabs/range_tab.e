indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RANGE_TAB

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
			create cmd1.make (~set_leap)
			create cmd2.make (~get_leap)
			create f1.make (Current, 0, 0, "Leap Value", cmd1, cmd2)
			create h1.make (Current)
			set_child_position (h1, 1, 0, 2, 3)
			
			create b1.make_with_text(Current, "Increase Leap")
			create cmd1.make (~leap_forward)
			b1.add_click_command (cmd1, Void)
			b1.set_vertical_resize(False)
			set_child_position (b1, 2, 0, 3, 3)


			create b2.make_with_text(Current, "Decrease Leap")
			create cmd2.make (~leap_backward)
			b2.add_click_command (cmd2, Void)
			b2.set_vertical_resize(False)
			set_child_position (b2, 2, 1, 3, 2)
		end

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Range"
		end

	current_widget: EV_RANGE

feature -- Access

	
	set_leap (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Is the mode of the progress bar continuous?
		do
			current_widget.set_leap(f1.get_text.to_integer)
		end

	get_leap (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Return the leap value of the range gauge
		do
			f1.set_text(current_widget.leap.out)
		end

	leap_forward(arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Increase the leap value of the range gauge.
		do
			current_widget.leap_forward
		end

	leap_backward (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Decrease the leap value of the range gauge.
		do
			current_widget.leap_backward
		end



	b1,b2: EV_BUTTON
	f1: TEXT_FEATURE_MODIFIER
end -- class RANGE_TAB

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

