indexing
	description: 
		"Base class for buttons that have two states (See `is_selected')."
	status: "See notice at end of class"
	keywords: "state, toggle, button"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_SELECT_BUTTON

inherit
	EV_BUTTON
		redefine
			implementation
		end
	
feature -- Status report
	
	is_selected: BOOLEAN is
			-- Is button depressed?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_selected
		ensure
			bridge_ok: Result = implementation.is_selected
		end 
	
feature -- Status setting

	enable_select is
			-- Set `is_selected' `True'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_select
		ensure
			is_selected: is_selected
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_SELECT_BUTTON_I
			-- Responsible for interaction with native graphics toolkit.

end -- class EV_SELECT_BUTTON

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--|-----------------------------------------------------------------------------
