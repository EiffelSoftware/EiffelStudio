indexing
	description:
		"Abstraction for objects that may be selected."
	status: "See notice at end of class"
	keywords: "select, selected, selectable"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_SELECTABLE

inherit
	EV_ANY
		redefine
			implementation
		end
	
feature -- Status report

	is_selected: BOOLEAN is
			-- Is selected.
		require
			not_destroyed: not is_destroyed
		do
			if is_selectable then
				Result := implementation.is_selected
			end
		ensure
			bridge_ok: is_selectable implies Result = implementation.is_selected
		end

	is_selectable: BOOLEAN is
			-- May `enable_select' be called.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_selectable
		end

feature -- Status setting

	enable_select is
			-- Make `is_selected' True.
		require
			not_destroyed: not is_destroyed
			is_selectable: is_selectable
		do
			implementation.enable_select
		ensure
			is_selected: is_selected
		end

feature {EV_ANY_I} -- Implementation
	
	implementation: EV_SELECTABLE_I
			-- Responsible for interaction with native graphics toolkit.

end -- class EV_SELECTABLE

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

