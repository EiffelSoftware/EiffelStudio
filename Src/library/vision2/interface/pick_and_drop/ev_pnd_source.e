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

inherit
	EV_ANY
		redefine
			implementation
		end

feature -- Attributes 

	transported_data: ANY is
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

	activate_pick_and_drop (mouse_button: INTEGER; cmd: EV_COMMAND; args: EV_ARGUMENT) is
			-- Activate the mechanism of pick and drop,
			-- when clicking on the `mouse_button'.
			-- Add `cmd' (if not Void) to the list of commands to be
			-- executed just before initializing the transport.
		require
			valid_button: mouse_button > 0 and then mouse_button < 4	
		do
			implementation.activate_pick_and_drop (mouse_button, cmd, args)
		end

	set_pick_position (a_x, a_y: INTEGER) is
			-- Set the initial position for the pick and drop.
		do
			implementation.set_pick_position (a_x, a_y)
		end

	set_transported_data (dt: like transported_data) is
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

