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

	transported_data: EV_PND_DATA
			-- Transported data

	data_type: EV_PND_TYPE
			-- Type of the transported data

	initial_point: EV_POINT
			-- Initial point for the pick and drop

feature -- Access

	transportable: BOOLEAN is
			-- Is the data transportable.
		do
			Result := transported_data /= Void and then data_type /= Void
		end

	activate_pick_and_drop (mouse_button: INTEGER; dt: EV_PND_DATA; dt_type: EV_PND_TYPE; cmd: EV_COMMAND; args: EV_ARGUMENT) is
			-- Activate the mechanism through which the current stone
			-- may be dragged and dropped, when right clicking.
			-- Add `cmd' (if not Void) to the list of commands to be
			-- executed when initializing the transport.
		require
			valid_data: dt /= Void
			valid_type: dt_type /= Void	
		local
			com: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT3 [INTEGER, TUPLE [EV_COMMAND, EV_ARGUMENT], EV_COMMAND]
		do
			transported_data := dt
			data_type := dt_type
			check
				transportable: transportable
			end
			!! com.make (~initialize_transport)
			!! arg.make (mouse_button, [cmd, args], com)
			add_button_press_command (mouse_button, com, arg)
		end

	set_pick_position (a_x, a_y: INTEGER) is
			-- Set the initial position for the pick and drop.
		do
			!! initial_point.set (a_x, a_y)
		end

	set_transported_data (dt: EV_PND_DATA) is
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
		deferred
		end

	add_button_release_command (mouse_button: INTEGER; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when button no 'mouse_button' is released.
		require
			exists: not destroyed
			valid_command: cmd /= Void
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

