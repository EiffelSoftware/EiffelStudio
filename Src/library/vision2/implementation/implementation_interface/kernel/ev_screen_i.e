indexing 
	description: "EiffelVision screen. Implementation interface."
	status: "See notice at end of class"
	keywords: "screen, root, window, visual, top"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SCREEN_I

inherit
	EV_DRAWABLE_I
		redefine
			interface
		end

feature -- Status report

	pointer_position: EV_COORDINATE is
			-- Position of the screen pointer.
		deferred
		end

	widget_at_position (x, y: INTEGER): EV_WIDGET is
			-- Widget at position (`x', `y') if any.
		deferred
		end

feature -- Basic operation

	set_pointer_position (a_x, a_y: INTEGER) is
			-- Set `pointer_position' to (`a_x',`a_y`).		
		deferred
		end

	fake_pointer_button_press (a_button: INTEGER) is
			-- Simulate the user pressing a `a_button' on the pointing device.
		deferred
		end

	fake_pointer_button_release (a_button: INTEGER) is
			-- Simulate the user releasing a `a_button' on the pointing device.
		deferred
		end

	fake_key_press (a_key: EV_KEY) is
			-- Simulate the user pressing a `key'.
		deferred
		end

	fake_key_release (a_key: EV_KEY) is
			-- Simulate the user releasing a `key'.
		deferred
		end

feature -- Measurement

	width: INTEGER is
		-- Horizontal size in pixels.
	deferred
        ensure
            positive: Result > 0
        end

	height: INTEGER is
		-- Vertical size in pixels.
	deferred
	ensure
		positive: Result > 0
	end

feature {NONE} -- Implementation

	interface: EV_SCREEN

end -- class EV_SCREEN_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

