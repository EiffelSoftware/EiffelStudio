indexing
	description: 
		"%"Hello world%" application."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	HELLO_WORLD

inherit
	EV_APPLICATION

create
	make_and_launch

feature -- Initialization

	prepare is
			-- Set up `first_window'.
		local
			b: EV_BUTTON
		do
			create b.make_with_text ("Hello world")
			b.select_actions.extend (~on_button_select)
			first_window.extend (b)
		end

feature -- Actions

	on_button_select is
			-- Output text that a button has been pressed.
		do
			io.put_string ("Button pressed%N")
		end

feature -- Access

	first_window: MAIN_WINDOW is
			-- Main window of the example
		once
			create Result
		end
	
end -- class HELLO_WORLD

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

