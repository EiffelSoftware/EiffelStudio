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
			Result := implementation.transportable
		end

	activate_pick_and_drop (mouse_button: INTEGER; dt: EV_PND_DATA; dt_type: EV_PND_TYPE) is
			-- Activate the mechanism through which
			-- the current stone may be dragged and
			-- dropped, when right clicking.
		require
			valid_data: dt /= Void
			valid_type: dt_type /= Void
		do
			default_activate_pnd (Void, mouse_button, dt, dt_type)
		end

	default_activate_pnd (pt: EV_POINT; mouse_button: INTEGER; dt: EV_PND_DATA; dt_type: EV_PND_TYPE) is
			-- Activate the pick and drop mechanism.
			-- Draw a line from the point `pt'
			-- to the current cursor position.
		require
			valid_data: dt /= Void
			valid_type: dt_type /= Void
		do
			implementation.activate_pick_and_drop (pt, mouse_button, dt, dt_type)
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

