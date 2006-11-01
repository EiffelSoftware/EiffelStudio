indexing
	description: 
		"Main window class of the test event example."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
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
			Precursor {EV_WINDOW}
			set_title ("Test events")

			-- Common datas
			create color.make_rgb (0, 0, 255)
			create cmd
			create box.make (Current)
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
			create arg.make ("Move event")
			add_move_command (cmd, arg)
			create arg.make ("Size event")
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
			create frame.make_with_text (par, "Button event")
			frame.set_foreground_color (color)
			create box.make (frame)

			-- Button press
			create button.make_with_text (box, "Button press")
			create arg.make ("Button press event")
			button.add_button_press_command (1, cmd, arg)

			-- Button release
			create button.make_with_text (box, "Button release")
			create arg.make ("Button release event")
			button.add_button_release_command (1, cmd, arg)

			-- Double click
			create button.make_with_text (box, "Double click")
			create arg.make ("Double click event")
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
			create frame.make_with_text (par, "Motion event")
			frame.set_foreground_color (color)
			create box.make (frame)

			-- Motion notify
			create button.make_with_text (box, "Motion notify")
			create arg.make ("Motion event")
			button.add_motion_notify_command (cmd, arg)

			-- Enter Notify
			create button.make_with_text (box, "Enter notify")
			create arg.make ("Enter notify event")
			button.add_enter_notify_command (cmd, arg)

			-- Leave notify
			create button.make_with_text (box, "Leave notify")
			create arg.make ("Leave notify event")
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
			create frame.make_with_text (par, "Key event")
			frame.set_foreground_color (color)
			create box.make (frame)

			-- Key press
			create button.make_with_text (box, "Key press")
			create arg.make ("Key press event")
			button.add_key_press_command (cmd, arg)

			-- Key release
			create button.make_with_text (box, "Key release")
			create arg.make ("Key release event")
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
			create frame.make_with_text (par, "Focus event")
			frame.set_foreground_color (color)
			create box.make (frame)

			-- Key press
			create button.make_with_text (box, "Get focus")
			create arg.make ("Get focus event")
			button.add_get_focus_command (cmd, arg)

			-- Key release
			create button.make_with_text (box, "Lose focus")
			create arg.make ("Lose focus event")
			button.add_lose_focus_command (cmd, arg)
		end

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


end -- class MAIN_WINDOW
 
