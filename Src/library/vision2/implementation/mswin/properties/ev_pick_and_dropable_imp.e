indexing
	description: "Implementation of a pick and drop source."
	status: "See notice at end of class"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PND_SOURCE_IMP

inherit
	EV_PND_SOURCE_I

	EV_EVENT_HANDLER_IMP

	EV_WIDGET_EVENTS_CONSTANTS_IMP

feature -- Implementation

	initialize_transport (args: EV_ARGUMENT3 [INTEGER, EV_POINT, EV_COMMAND]; data: EV_EVENT_DATA) is
			-- Initialize the pick and drop mechanism.
		local
			transporter: EV_PND_TRANSPORTER_IMP
			arg1, arg2: EV_ARGUMENT3 [INTEGER, EV_PND_SOURCE_IMP, INTEGER]
			mouse_button: INTEGER
		do
			mouse_button := args.first
			if transportable then
				!! transporter
				transporter.transport (Current, args.second)
				!! arg1.make (2, Current, mouse_button)
				!! arg2.make (3, Current, mouse_button) 
				inspect mouse_button
				when 1 then
					remove_single_command (Cmd_button_one_press, args.third)
					add_command (Cmd_button_one_press, transporter, arg1)
					add_command (Cmd_button_two_release, transporter, arg2)
					add_command (Cmd_button_three_release, transporter, arg2)
				when 2 then
					remove_single_command (Cmd_button_two_press, args.third)
					add_command (Cmd_button_two_press, transporter, arg1)
					add_command (Cmd_button_one_release, transporter, arg2)
					add_command (Cmd_button_three_release, transporter, arg2)
				when 3 then
					remove_single_command (Cmd_button_three_press, args.third)
					add_command (Cmd_button_three_press, transporter, arg1)
					add_command (Cmd_button_one_release, transporter, arg2)
					add_command (Cmd_button_two_release, transporter, arg2)
				end
				!! arg1.make (1, Void, mouse_button)
				add_command (Cmd_motion_notify, transporter, arg1)
			end
		end

	terminate_transport (transporter: EV_PND_TRANSPORTER_IMP; mouse_button: INTEGER) is
			-- Terminate the pick and drop mechanim.
		local
			cmd: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT2 [INTEGER, EV_COMMAND]
		do
			!! cmd.make (~initialize_transport)
			!! arg.make (mouse_button, cmd)
			inspect mouse_button
			when 1 then
				remove_single_command (Cmd_button_one_press, transporter)
				remove_single_command (Cmd_button_two_release, transporter)
				remove_single_command (Cmd_button_three_release, transporter)
				add_command (Cmd_button_one_press, cmd, arg)
			when 2 then
				remove_single_command (Cmd_button_two_press, transporter)
				remove_single_command (Cmd_button_one_release, transporter)
				remove_single_command (Cmd_button_three_release, transporter)
				add_command (Cmd_button_two_press, cmd, arg)
			when 3 then
				remove_single_command (Cmd_button_three_press, transporter)
				remove_single_command (Cmd_button_one_release, transporter)
				remove_single_command (Cmd_button_two_release, transporter)
				add_command (Cmd_button_three_press, cmd, arg)
			end
			remove_single_command (Cmd_motion_notify, transporter)
		end

feature {EV_PND_TRANSPORTER_IMP} -- Implemented in WIDGET_IMP.

	set_capture is
		deferred
		end

	release_capture is
		deferred
		end

end -- class EV_PND_SOURCE_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

