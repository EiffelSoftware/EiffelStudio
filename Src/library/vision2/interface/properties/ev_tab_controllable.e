indexing
	description:
		"Abstraction for objects that may have their ability to be tabbed to enabled/disabled."
	status: "See notice at end of class"
	keywords: "select, selected, selectable"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_TAB_CONTROLABLE

inherit
	EV_ANY
		redefine
			implementation
		end
	
feature -- Status report

	is_tabable_to: BOOLEAN is
			-- Is Current able to be tabbed to?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_tabable_to
		end

	is_tabable_from: BOOLEAN is
			-- Is Current able to be tabbed from?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_tabable_from
		end

feature -- Status setting

	enable_tabable_to is
			-- Make `is_tabable_to' `True'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_tabable_to
		ensure
			is_tabable_to: is_tabable_to
		end

	disable_tabable_to is
			-- Make `is_tabable_to' `False'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_tabable_to
		ensure
			not_is_tabable_to: not is_tabable_to
		end

	enable_tabable_from is
			-- Make `is_tabable_from' `True'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_tabable_from
		ensure
			is_tabable_from: is_tabable_from
		end

	disable_tabable_from is
			-- Make `is_tabable_from' `False'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_tabable_from
		ensure
			not_is_tabable_from: not is_tabable_from
		end

feature {EV_ANY, EV_ANY_I} -- Implementation
	
	implementation: EV_TAB_CONTROLABLE_I
			-- Responsible for interaction with native graphics toolkit.

end -- class EV_TAB_CONTROLABLE

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------