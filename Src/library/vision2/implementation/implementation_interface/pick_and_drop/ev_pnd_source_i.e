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

	transported_data: ANY
			-- Transported data

	data_type: EV_PND_TYPE
			-- Type of the transported data

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

	activate_pick_and_drop (mouse_button: INTEGER; cmd: EV_COMMAND; args: EV_ARGUMENT) is
			-- Activate the mechanism of pick and drop,
			-- when clicking on the `mouse_button'.
			-- Add `cmd' (if not Void) to the list of commands to be
			-- executed just before initializing the transport.
		require
			valid_button: mouse_button > 0 and then mouse_button < 4	
		local
			com: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT3 [INTEGER, TUPLE [EV_COMMAND, EV_ARGUMENT], EV_COMMAND]
		do
			!! com.make (~initialize_transport)
			!! arg.make (mouse_button, [cmd, args], com)
			add_button_press_command (mouse_button, com, arg)
		end

	set_pick_position (a_x, a_y: INTEGER) is
			-- Set the initial position for the pick and drop.
		do
			!! initial_point.set (a_x, a_y)
		end

	set_transported_data (dt: like transported_data) is
			-- Set the `transported_data'.
		do
			transported_data := dt
		end

	set_data_type (dt_type: EV_PND_TYPE) is
			-- Make `dt_type' the new data type.
		do
			data_type := dt_type
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

feature {EV_PND_SOURCE_I} -- Implementation

	initialize_transport (args: EV_ARGUMENT3 [INTEGER, TUPLE [EV_COMMAND, EV_ARGUMENT], EV_COMMAND]; data: EV_BUTTON_EVENT_DATA) is
			-- Initialize the pick and drop mechanism.
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

