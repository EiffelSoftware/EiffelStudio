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
			widg: EV_WIDGET_IMP
		do	
			if not ev_data.first_button_pressed
			and then not ev_data.second_button_pressed
			and then not ev_data.shift_key_pressed
			and then not ev_data.control_key_pressed
			and not avoid_callback
			then
				if args.first /= Void then
					args.first.execute (ev_data)
				end
				if transportable then
					create transporter

					-- FIXME IEK  We need to somehow suspend all of the previous motion commands

					--widget_source.add_motion_notify_command (transporter, arg1)

					if initial_point /= Void then
						transporter.start_from (Current, initial_point.x, initial_point.y)
					else
						transporter.start_from (Current, ev_data.absolute_x, ev_data.absolute_y)
					end
						-- We add the commands

					
					remove_single_command (widget_source.widget, 3, initialized_command)
					
					create cancel_cmd.make (transporter~cancel_command)
					create arg.make (Current, args.first)

					create dummy_drop.make (~drop_callback)
					create drop_cmd.make (transporter~drop_command)
					widget_source.add_button_press_command (3, dummy_drop, arg)
					just_initialized := True

					widget_source.add_button_press_command (1, cancel_cmd, arg)

					widget_source.add_button_press_command (2, cancel_cmd, arg)


						-- We set a command that draw the line
					create arg1.make (Current)
					--widget_source.add_motion_notify_command (transporter, arg1)
				end
			else
				avoid_callback := False
			end
		end

	just_initialized, avoid_callback: BOOLEAN
			-- Booleans used to prevent unneeded execution of callbacks.

	drop_callback (args: EV_ARGUMENT2 [EV_PND_SOURCE_I, EV_INTERNAL_COMMAND]; ev_data: EV_PND_EVENT_DATA) is
		local
			data_imp: EV_BUTTON_EVENT_DATA_IMP
			widg: EV_WIDGET
		do
			if not just_initialized then
				data_imp ?= ev_data.implementation
				widg ?= widget_source.interface
				data_imp.set_widget (widg)
				drop_cmd.execute (args, ev_data)
			else
				just_initialized := False
			end
			
		end
		

	terminate_transport (cmd: EV_INTERNAL_COMMAND; flag: BOOLEAN) is
			-- Terminate the pick and drop mechanism.
		local
			arg: EV_ARGUMENT2 [EV_INTERNAL_COMMAND, EV_COMMAND]
		do
			remove_pick_and_drop
			create initialized_command.make (~initialize_transport)
			create arg.make (cmd, initialized_command)
		
			if flag then
				avoid_callback := True
			else
				avoid_callback := False
			end
		
			add_button_press_command (3, initialized_command, arg)
			
		end


feature {NONE} -- Implementation

	remove_pick_and_drop is
			-- Deactivate the pick and drop mechanism.
			-- We remove the commands for the pick and drop.
			-- (1, 2 & 3 = Left, Middle & Right mouse buttons).
		do
			if drop_cmd /= Void then
				remove_single_command (widget_source.widget, 3, dummy_drop)
				drop_cmd := Void
			end
			if cancel_cmd /= Void then
				remove_single_command (widget_source.widget, 1, cancel_cmd)
				remove_single_command (widget_source.widget, 2, cancel_cmd)
				cancel_cmd := Void
			end
			if transporter /= Void then
				--remove_motion_notify_commands (widget_source.widget, Cmd_motion_notify, transporter)
				--widget_source.remove_motion_notify_commands
				--| FIXME IEK We only need to remove the transporter from the motion events queue

				transporter := Void
			end
		end

	transporter: EV_PND_TRANSPORTER_IMP

	dummy_drop, drop_cmd, cancel_cmd: EV_ROUTINE_COMMAND
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
