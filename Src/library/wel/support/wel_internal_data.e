indexing
	description: "Small wrapper around the EIF_WEL_USERDATA C structure."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_INTERNAL_DATA
	
feature -- Access
	
	frozen structure_size: INTEGER is
			-- Size of EIF_WEL_USERDATA C structure.
		external
			"C macro use %"disptchr.h%""
		alias
			"sizeof(struct EIF_WEL_USERDATA)"
		end
		
	frozen object_id (p: POINTER): INTEGER is
			-- Retrieve `object_id' from `p'
		external
			"C struct struct EIF_WEL_USERDATA access object_id use %"disptchr.h%""
		end

	frozen default_window_procedure (p: POINTER): POINTER is
			-- Retrieve `default_window_procedure' from `p'
		external
			"C struct struct EIF_WEL_USERDATA access default_window_procedure use %"disptchr.h%""
		end
		
feature -- Setting

	frozen set_object_id (p: POINTER; id: INTEGER) is
			-- Set `object_id' from `p' with `id'.
		external
			"C struct struct EIF_WEL_USERDATA access object_id type EIF_INTEGER use %"disptchr.h%""
		end

	frozen set_default_window_procedure (p: POINTER; proc: POINTER) is
			-- Set `default_window_procedure' from `p' with `proc'.
		external
			"C struct struct EIF_WEL_USERDATA access default_window_procedure type WNDPROC use %"disptchr.h%""
		end
		
end -- class WEL_INTERNAL_DATA

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

