indexing
	description: "Objects that display all events executed on a widget."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIDGET_COMMANDS

feature -- Initialization

	add_widget_commands (w: EV_ANY; e: EVENT_WINDOW; name: STRING) is
			-- Initialize commands for widgets.
		local
			cmd: EV_ROUTINE_COMMAND
			widget: EV_WIDGET
		do
			widget_current_name := name
			widget_e_window := e
			widget ?= w
			create cmd.make (~button1_pressed_command)
			widget.add_button_press_command (1, cmd, Void)
			create cmd.make (~button2_pressed_command)
			widget.add_button_press_command (2, cmd, Void)
			create cmd.make (~button3_pressed_command)
			widget.add_button_press_command (3, cmd, Void)
			create cmd.make (~button1_release_command)
			widget.add_button_release_command (1, cmd, Void)
			create cmd.make (~button2_release_command)
			widget.add_button_release_command (2, cmd, Void)
			create cmd.make (~button3_release_command)
			widget.add_button_release_command (3, cmd, Void)
			create cmd.make (~button1_double_clicked_command)
			widget.add_double_click_command (1, cmd, Void)
			create cmd.make (~button2_double_clicked_command)
			widget.add_double_click_command (2, cmd, Void)
			create cmd.make (~button3_double_clicked_command)
			widget.add_double_click_command (3, cmd, Void)
			create cmd.make (~motion_notify_command)
			widget.add_motion_notify_command (cmd, Void)
			create cmd.make (~key_press_command)
			widget.add_key_press_command (cmd, Void)
			create cmd.make (~key_release_command)
			widget.add_key_release_command (cmd, Void)
			create cmd.make (~enter_notify_command)
			widget.add_enter_notify_command (cmd, Void)
			create cmd.make (~leave_notify_command)
			widget.add_leave_notify_command (cmd, Void)
		end

feature -- Access

	widget_e_window: EVENT_WINDOW

	widget_current_name: STRING

feature -- Basic operations

	button1_pressed_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When mouse button one is pressed, inform user in `widget_e_window'
		local
			temp_string: STRING
		do
			temp_string :="Mouse button one pressed in "
			temp_string.append_string (widget_current_name)
			temp_string.append_string (".")
			widget_e_window.display (temp_string)
		end

	button2_pressed_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When mouse button two is pressed, inform user in `widget_e_window'
		local
			temp_string: STRING
		do
			temp_string :="Mouse button two pressed in "
			temp_string.append_string (widget_current_name)
			temp_string.append_string (".")
			widget_e_window.display (temp_string)
		end


	button3_pressed_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When mouse button three is pressed, inform user in `widget_e_window'
		local
			temp_string: STRING
		do
			temp_string :="Mouse button three pressed in "
			temp_string.append_string (widget_current_name)
			temp_string.append_string (".")
			widget_e_window.display (temp_string)
		end


	button1_release_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When mouse button one is released, inform user in `widget_e_window'
		local
			temp_string: STRING
		do
			temp_string :="Mouse button one released in "
			temp_string.append_string (widget_current_name)
			temp_string.append_string (".")
			widget_e_window.display (temp_string)
		end


	button2_release_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When mouse button two is released, inform user in `widget_e_window'
		local
			temp_string: STRING
		do
			temp_string :="Mouse button two released in "
			temp_string.append_string (widget_current_name)
			temp_string.append_string (".")
			widget_e_window.display (temp_string)
		end


	button3_release_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When mouse button three is released, inform user in `widget_e_window'
		local
			temp_string: STRING
		do
			temp_string :="Mouse button three released in "
			temp_string.append_string (widget_current_name)
			temp_string.append_string (".")
			widget_e_window.display (temp_string)
		end


	button1_double_clicked_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When mouse button one is double_clicked, inform user in `widget_e_window'
		local
			temp_string: STRING
		do
			temp_string :="Mouse button one double clicked in "
			temp_string.append_string (widget_current_name)
			temp_string.append_string (".")
			widget_e_window.display (temp_string)
		end


	button2_double_clicked_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When mouse button two is double clicked, inform user in `widget_e_window'
		local
			temp_string: STRING
		do
			temp_string :="Mouse button two double clicked in "
			temp_string.append_string (widget_current_name)
			temp_string.append_string (".")
			widget_e_window.display (temp_string)
		end


	button3_double_clicked_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When mouse button three is double clicked, inform user in `widget_e_window'
		local
			temp_string: STRING
		do
			temp_string :="Mouse button three double clicked in "
			temp_string.append_string (widget_current_name)
			temp_string.append_string (".")
			widget_e_window.display (temp_string)
		end


	motion_notify_command (arg: EV_ARGUMENT; data:EV_EVENT_DATA) is
			-- When mouse is moved, inform user in `widget_e_window'
		local
			ev: EV_MOTION_EVENT_DATA
			temp_string: STRING
		do
			if widget_e_window.motion_tracking_on then
				ev ?= data
				temp_string := "Mouse moved in the "
				temp_string.append_string (widget_current_name)
				temp_string.append_string (".")
				widget_e_window.display (temp_string)
				temp_string := "X : "
				temp_string.append_string (ev.x.out)
				temp_string.append_string (" Y : ")
				temp_string.append_string (ev.y.out)
				widget_e_window.displayi (temp_string)
			end
		end

	key_press_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When a key is pressed, inform user in `event window'
		local
			ev: EV_KEY_EVENT_DATA
			temp_string: STRING
		do
			ev ?= data
			temp_string := "Key pressed in the "
			temp_string.append_string (widget_current_name)
			temp_string.append_string (".")
			widget_e_window.display (temp_string)
			widget_e_window.displayi (ev.keycode.out)
		end

	key_release_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When a key is released, inform user in `event window'
		local
			ev: EV_KEY_EVENT_DATA
			temp_string: STRING
		do
			ev ?= data
			temp_string := "Key released in the "
			temp_string.append_string (widget_current_name)
			temp_string.append_string(".")
			widget_e_window.display (temp_string)
			widget_e_window.displayi (ev.keycode.out)
		end

	enter_notify_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When the cursor enters `widget' then inform the user in `event window'
		local
			temp_string: STRING
		do
			temp_string := "Cursor has entered the "
			temp_string.append_string (widget_current_name)
			temp_string.append_string (".")
			widget_e_window.display (temp_string)
		end

	leave_notify_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When the cursor leaves `widget' then inform the user in `event window'
		local
			temp_string: STRING
		do
			temp_string := "Cursor has left the "
			temp_string.append_string (widget_current_name)
			temp_string.append_string (".")
			widget_e_window.display (temp_string)
		end


end -- class WIDGET_COMMANDS

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

