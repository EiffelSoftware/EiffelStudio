indexing
	description: "The source of the transport, i.e. the widget which, when %
			%clicked on with the right mouse button, initializes the transport.%
			%It also specifies data transported and its type."
	status: "See notice at end of class"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PND_SOURCE


feature -- Attributes 

	transported_data: EV_PND_DATA is
			-- Transported data
		do
			Result := implementation.transported_data
		end

	data_type: EV_PND_TYPE is
			-- Type of the transported data
		do
			Result := implementation.data_type
		end

feature -- Access

	transportable: BOOLEAN is
			-- Is the data transportable.
		do
			Result := transported_data /= Void and then data_type /= Void
		end

	default_activate_pnd (mouse_button: INTEGER; dt: EV_PND_DATA; dt_type: EV_PND_TYPE) is
			-- Activate the mechanism through which
			-- the current stone may be dragged and
			-- dropped, when right clicking.
		require
			valid_type: dt_type /= Void
		do
			implementation.activate_pick_and_drop (mouse_button, dt, dt_type, Void, Void)
		end

	activate_pick_and_drop (mouse_button: INTEGER; dt: EV_PND_DATA; dt_type: EV_PND_TYPE; cmd: EV_COMMAND; args: EV_ARGUMENT) is
			-- Activate the mechanism through which the current stone
			-- may be dragged and dropped, when right clicking.
			-- Add `cmd' (if not Void) to the list of commands to be
			-- executed when initializing the transport.
		require
			valid_type: dt_type /= Void
		do
			implementation.activate_pick_and_drop (mouse_button, dt, dt_type, cmd, args)
		end

	set_pick_position (a_x, a_y: INTEGER) is
			-- Set the initial position for the pick and drop.
		do
			implementation.set_pick_position (a_x, a_y)
		end

	set_transported_data (dt: EV_PND_DATA) is
			-- Set the `transported_data'.
		do
			implementation.set_transported_data (dt)
		end

	set_data_type (dt_type: EV_PND_TYPE) is
			-- Make `dt_type' the new data type.
		do
			implementation.set_data_type (dt_type)
		end

feature {NONE} -- Implementation

	implementation: EV_PND_SOURCE_I
			-- Implementation of current pick and drop source

end -- class EV_PND_SOURCE

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

