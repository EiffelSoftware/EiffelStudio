indexing
	description: "Implementation interface of a pick and drop source."
	status: "See notice at end of class"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PND_SOURCE_I

inherit
	EV_ANY_I

feature -- Attributes 

	transported_data: ANY is
			-- Transported data
		local
			interf: EV_PND_SOURCE
		do
			interf ?= interface
			Result := interf.transported_data
		end

	data_type: EV_PND_TYPE is
			-- Type of the transported data
		local
			interf: EV_PND_SOURCE
		do
			interf ?= interface
			Result := interf.data_type
		end

	initial_point: EV_COORDINATES
			-- Initial point for the pick and drop

feature -- Access

	transportable: BOOLEAN is
			-- Is the data transportable.
		local
			interf: EV_PND_SOURCE
		do
			interf ?= interface
			Result := interf.transportable
		end

	activate_pick_and_drop (cmd: EV_COMMAND; args: EV_ARGUMENT) is
			-- Activate the mechanism of pick and drop,
			-- when clicking on the right button of the mouse.
			-- Add `cmd' (if not Void) to the list of commands to be
			-- executed just before initializing the transport.
		local
			com: EV_ROUTINE_COMMAND
			icom: EV_INTERNAL_COMMAND
			arg: EV_ARGUMENT2 [EV_INTERNAL_COMMAND, EV_COMMAND]
		do
			create com.make (~initialize_transport)
			if cmd /= Void then
				create icom.make (cmd, args)
			end
			create arg.make (icom, com)
			add_button_press_command (3, com, arg)
		end

	set_pick_position (a_x, a_y: INTEGER) is
			-- Set the initial position for the pick and drop.
		do
			create initial_point.set (a_x, a_y)
		end

feature -- Event - command association

	add_button_press_command (mouse_button: INTEGER; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when button no 'mouse_button' is pressed.
		require
			exists: not destroyed
			valid_command: cmd /= Void
			button_large_enough: mouse_button > 0
			button_small_enough: mouse_button < 4
		deferred
		end

	add_button_release_command (mouse_button: INTEGER; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when button no 'mouse_button' is released.
		require
			exists: not destroyed
			valid_command: cmd /= Void
			button_large_enough: mouse_button > 0
			button_small_enough: mouse_button < 4
		deferred
		end

feature -- Event -- removing command association

	remove_button_press_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is pressed.
		require
			exists: not destroyed
		deferred
		end

	remove_button_release_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is released.
		require
			exists: not destroyed
		deferred
		end

feature {EV_PND_SOURCE_I} -- Implementation

	initialize_transport (args: EV_ARGUMENT2 [EV_INTERNAL_COMMAND, EV_COMMAND]; ev_data: EV_BUTTON_EVENT_DATA) is
			-- Initialize the pick and drop mechanism.
		deferred
		end

feature {EV_PND_TRANSPORTER_I} -- Implemented in descendants

	terminate_transport (transporter: EV_PND_TRANSPORTER_I; cmd: EV_INTERNAL_COMMAND) is
			-- Terminate the pick and drop mechanim.
	deferred
	end

	widget_source: EV_WIDGET_IMP is
			-- Widget drag source used for transport
		deferred
		end

end -- class EV_PND_SOURCE_I

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

