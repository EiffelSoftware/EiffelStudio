indexing
	description: 
		"Eiffel Vision selectable. Implementation interface."
	status: "See notice at end of class"
	keywords: "select, selectable"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_SELECTABLE_I

inherit
	EV_ANY_I
		redefine
			interface
		end
	
feature -- Status report

	is_selectable: BOOLEAN is
			-- May the object be selected.
		do
			Result := True
		end

	is_selected: BOOLEAN is
			-- Is objects state set to selected.
		deferred
		end

feature -- Status setting

	enable_select is
			-- Select the object.
		require
			is_selectable: is_selectable
		deferred
		ensure
			selected: is_selected
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_SELECTABLE
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'.

end -- class EV_SELECTABLE_I

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

