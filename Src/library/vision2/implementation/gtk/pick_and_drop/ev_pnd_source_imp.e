indexing
	description: "Implementation interface of a pick and drop source."
	status: "See notice at end of class"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PND_SOURCE_IMP

inherit
	EV_PND_SOURCE_I

	EV_EVENT_HANDLER_IMP

feature -- Implementation

	initialize_transport (args: EV_ARGUMENT2 [EV_INTERNAL_COMMAND, EV_COMMAND]; ev_data: EV_BUTTON_EVENT_DATA) is
			-- Initialize the pick and drop mechanism.
		local
			arg: EV_ARGUMENT2 [like Current, EV_INTERNAL_COMMAND]
			arg1: EV_ARGUMENT1 [like Current]
		do
			if not ev_data.first_button_pressed
			and then not ev_data.second_button_pressed
			and then not ev_data.shift_key_pressed
			and then not ev_data.control_key_pressed
			then
				if args.first /= Void then
					args.first.execute (ev_data)
				end
				if transportable then
					create transporter
					if initial_point /= Void then
						transporter.start_from (Current, initial_point.x, initial_point.y)
					else
						--transporter.start_from (Current, ev_data.absolute_x, ev_data.absolute_y)
						transporter.start_from (Current, 10, 10)
					end
						-- We add the commands
					--remove_single_command (Cmd_button_three_press, args.second)
					create drop_cmd.make (transporter~drop_command)
					create cancel_cmd.make (transporter~cancel_command)
					create arg.make (Current, args.first)
					--widget_source.add_command (Cmd_button_three_press, drop_cmd, arg)
					--widget_source.add_command (Cmd_button_one_press, cancel_cmd, arg)
					--widget_source.add_command (Cmd_button_two_press, cancel_cmd, arg)
						-- We set a command that draw the line
					create arg1.make (Current)
					--widget_source.add_command (Cmd_motion_notify, transporter, arg1)
				end
			end
		end

	terminate_transport (cmd: EV_INTERNAL_COMMAND) is
			-- Terminate the pick and drop mechanim.
		local
			com: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT2 [EV_INTERNAL_COMMAND, EV_COMMAND]
		do
			remove_pick_and_drop
			create com.make (~initialize_transport)
			create arg.make (cmd, com)
			--add_command (Cmd_button_three_press, com, arg)
		end


feature {NONE} -- Implementation

	remove_pick_and_drop is
			-- Desactivate the pick and drop mechanism.
			-- We remove the commands for the pick and drop.
		do
			if drop_cmd /= Void then
			--	widget_source.remove_single_command (Cmd_button_three_press, drop_cmd)
				drop_cmd := Void
			end
			if cancel_cmd /= Void then
			--	widget_source.remove_single_command (Cmd_button_one_press, cancel_cmd)
			--	widget_source.remove_single_command (Cmd_button_two_press, cancel_cmd)
				cancel_cmd := Void
			end
			if transporter /= Void then
			--	widget_source.remove_single_command (Cmd_motion_notify, transporter)
				transporter := Void
			end
		end

	transporter: EV_PND_TRANSPORTER_IMP

	drop_cmd, cancel_cmd: EV_ROUTINE_COMMAND
			-- Pick and Drop commands


end -- class EV_PND_SOURCE_I

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
