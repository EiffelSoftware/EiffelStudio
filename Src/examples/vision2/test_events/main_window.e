indexing
	description: 
		"Main window class of the test event example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	MAIN_WINDOW

inherit
	EV_WINDOW
		redefine	
			make_top_level
		end

creation
	make_top_level

feature -- Initialization
	
	make_top_level is
			-- Creation of the window.
		local
			cmd: COMMAND
			color: EV_COLOR
			box: EV_HORIZONTAL_BOX
			box2: EV_VERTICAL_BOX
		do
			{EV_WINDOW} Precursor
			set_title ("Test events")

			-- Common datas
			!! color.make_rgb (0, 0, 255)
			!! cmd
			!! box.make (Current)
			box.set_spacing (5)

			-- Differents frame and events
			set_window_events (cmd)
			create_button_frame (box, cmd, color)
			create_motion_frame (box, cmd, color)
			create_key_frame (box, cmd, color)
			create_focus_frame (box, cmd, color)
		end

	set_window_events (cmd: EV_COMMAND) is
				-- Create a frame for the expose event.
		local
			arg: EV_ARGUMENT1 [STRING]
		do
			!! arg.make ("Move event")
			add_move_command (cmd, arg)
			!! arg.make ("Size event")
			add_resize_command (cmd, arg)
		end

	create_button_frame (par: EV_CONTAINER; cmd: EV_COMMAND; color: EV_COLOR) is
				-- Create a frame for the expose event.
		local
			frame: EV_FRAME
			button: EV_BUTTON
			arg: EV_ARGUMENT1 [STRING]
			box: EV_VERTICAL_BOX
		do
			!! frame.make_with_text (par, "Button event")
			frame.set_foreground_color (color)
			!! box.make (frame)

			-- Button press
			!! button.make_with_text (box, "Button press")
			!! arg.make ("Button press event")
			button.add_button_press_command (1, cmd, arg)

			-- Button release
			!!button.make_with_text (box, "Button release")
			!! arg.make ("Button release event")
			button.add_button_release_command (1, cmd, arg)

			-- Double click
			!!button.make_with_text (box, "Double click")
			!! arg.make ("Double click event")
			button.add_double_click_command (1, cmd, arg)
		end

	create_motion_frame (par: EV_CONTAINER; cmd: EV_COMMAND; color: EV_COLOR) is
				-- Create a frame for the expose event.
		local
			frame: EV_FRAME
			button: EV_BUTTON
			arg: EV_ARGUMENT1 [STRING]
			box: EV_VERTICAL_BOX
		do
			!! frame.make_with_text (par, "Motion event")
			frame.set_foreground_color (color)
			!! box.make (frame)

			-- Motion notify
			!! button.make_with_text (box, "Motion notify")
			!! arg.make ("Motion event")
			button.add_motion_notify_command (cmd, arg)

			-- Enter Notify
			!! button.make_with_text (box, "Enter notify")
			!! arg.make ("Enter notify event")
			button.add_enter_notify_command (cmd, arg)

			-- Leave notify
			!! button.make_with_text (box, "Leave notify")
			!! arg.make ("Leave notify event")
			button.add_leave_notify_command (cmd, arg)
		end

	create_key_frame (par: EV_CONTAINER; cmd: EV_COMMAND; color: EV_COLOR) is
				-- Create a frame for the expose event.
		local
			frame: EV_FRAME
			button: EV_BUTTON
			arg: EV_ARGUMENT1 [STRING]
			box: EV_VERTICAL_BOX
		do
			!! frame.make_with_text (par, "Key event")
			frame.set_foreground_color (color)
			!! box.make (frame)

			-- Key press
			!! button.make_with_text (box, "Key press")
			!! arg.make ("Key press event")
			button.add_key_press_command (cmd, arg)

			-- Key release
			!! button.make_with_text (box, "Key release")
			!! arg.make ("Key release event")
			button.add_key_release_command (cmd, arg)
		end

	create_focus_frame (par: EV_CONTAINER; cmd: EV_COMMAND; color: EV_COLOR) is
				-- Create a frame for the expose event.
		local
			frame: EV_FRAME
			button: EV_BUTTON
			arg: EV_ARGUMENT1 [STRING]
			box: EV_VERTICAL_BOX
		do
			!! frame.make_with_text (par, "Focus event")
			frame.set_foreground_color (color)
			!! box.make (frame)

			-- Key press
			!! button.make_with_text (box, "Get focus")
			!! arg.make ("Get focus event")
			button.add_get_focus_command (cmd, arg)

			-- Key release
			!! button.make_with_text (box, "Lose focus")
			!! arg.make ("Lose focus event")
			button.add_lose_focus_command (cmd, arg)
		end

end -- class MAIN_WINDOW
 
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

