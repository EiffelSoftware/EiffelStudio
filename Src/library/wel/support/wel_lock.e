indexing
	description: "Objects that provide access to memory lock functions."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LOCK

feature -- Access

	c_local_lock (handle: POINTER): POINTER is
		external
			"C [macro %"wel.h%"] (HWND): HWND"
		alias
			"LocalLock"
		end	
		
	c_local_unlock (handle: POINTER) is
			--
		external
			"C [macro %"wel.h%"] (HWND)"
		alias
			"LocalUnlock"
		end	
	
end -- class WEL_LOCK

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

