indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	FIXED_WINDOW

inherit
	EV_FIXED
		redefine
			make
		end
	DEMO_WINDOW
	WIDGET_COMMANDS

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
		local
			cmd: EV_ROUTINE_COMMAND
		do
			{EV_FIXED} Precursor (par)

			!!button1.make_with_text (Current, "Press me")
			!!button2.make_with_text (Current, "Me too!")
			!! cmd.make (~execute1)
			button1.add_click_command (cmd, Void)
			button1.set_x_y (10, 20)
			button2.set_x_y (200, 50)
			xvel:=20
			yvel:=20
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "fixed window")
			set_parent (par)
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
			set_container_tabs
			create action_window.make (Current, tab_list)
		end


feature -- Access

	button1: EV_BUTTON
			-- a button for the demo

	button2: EV_BUTTON
			-- a button for the demo

	xvel: INTEGER
	yvel: INTEGER

feature -- Execution features

	execute1 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when we press the first button
		do
			button2.set_x_y (button2.x + xvel, button2.y + yvel)
			if (button2.x>=current.width-button2.width-xvel) or (button2.x<=-xvel) then
				xvel:=0-xvel
			elseif (button2.y>=current.height-button2.height-yvel) or (button2.y<=-yvel) then
				yvel:=0-yvel
			end

		end

end -- class FIXED_WINDOW

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

