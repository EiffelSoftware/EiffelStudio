indexing 
	description:
		"Facilities for direct drawing on the screen."
	status: "See notice at end of class"
	keywords: "screen, root, window, visual, top"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SCREEN

inherit
	EV_DRAWABLE
		redefine
			implementation,
			create_implementation
		end

create
	default_create

feature -- Status report

	pointer_position: EV_COORDINATE is
			-- Position of the screen pointer.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.pointer_position
		end 
	
	widget_at_position (x, y: INTEGER): EV_WIDGET is
			-- Widget at position (`x', `y') if any.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.widget_at_position (x, y)
		end

feature -- Basic operation

	set_pointer_position (x, y: INTEGER) is
			-- Set `pointer_position' to (`x',`y`).
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_pointer_position (x, y)
		end

	fake_pointer_button_press (a_button: INTEGER) is
			-- Simulate the user pressing a `a_button' on the pointing device.
		require
			not_destroyed: not is_destroyed
		do
			implementation.fake_pointer_button_press (a_button)
		end

	fake_pointer_button_release (a_button: INTEGER) is
			-- Simulate the user releasing a `a_button' on the pointing device.
		require
			not_destroyed: not is_destroyed
		do
			implementation.fake_pointer_button_release (a_button)
		end

	fake_pointer_button_click (a_button: INTEGER) is
			-- Simulate the user clicking `a_button' on the pointing device.
		require
			not_destroyed: not is_destroyed
		do
			implementation.fake_pointer_button_press (a_button)
			implementation.fake_pointer_button_release (a_button)
		end

	fake_key_press (a_key: EV_KEY) is
			-- Simulate the user pressing a `key'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.fake_key_press (a_key)
		end

	fake_key_release (a_key: EV_KEY) is
			-- Simulate the user releasing a `key'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.fake_key_release (a_key)
		end

	fake_key_click (a_key: EV_KEY) is
			-- Simulate the user clicking a `key'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.fake_key_press (a_key)
			implementation.fake_key_release (a_key)
		end

feature -- Measurement

	width: INTEGER is
			-- Horizontal size in pixels.				
		do
			Result := implementation.width
		ensure then
			bridge_ok: Result = implementation.width
			positive: Result > 0
		end

	height: INTEGER is
			-- Vertical size in pixels.
		do
			Result := implementation.height
		ensure then
			bridge_ok: Result = implementation.height
			positive: Result > 0
		end
		
feature {EV_ANY_I} -- Implementation

	implementation: EV_SCREEN_I
			-- Responsible for interaction with the native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_SCREEN_IMP} implementation.make (Current)
		end

invariant
	pointer_position_not_negative:
		pointer_position.x >= 0 and pointer_position.y >= 0

end -- class EV_SCREEN

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--!-----------------------------------------------------------------------------
