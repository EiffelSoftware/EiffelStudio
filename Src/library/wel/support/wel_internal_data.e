indexing
	description: "Small wrapper around the EIF_WEL_USERDATA C structure."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_INTERNAL_DATA
	
feature -- Access
	
	structure_size: INTEGER is
			-- Size of EIF_WEL_USERDATA C structure.
		external
			"C macro use %"disptchr.h%""
		alias
			"sizeof(struct EIF_WEL_USERDATA)"
		end
		
	object_id (p: POINTER): INTEGER is
			-- Retrieve `object_id' from `p'
		external
			"C struct struct EIF_WEL_USERDATA access object_id use %"disptchr.h%""
		end

	default_window_procedure (p: POINTER): POINTER is
			-- Retrieve `default_window_procedure' from `p'
		external
			"C struct struct EIF_WEL_USERDATA access default_window_procedure use %"disptchr.h%""
		end
		
feature -- Setting

	set_object_id (p: POINTER; id: INTEGER) is
			-- Set `object_id' from `p' with `id'.
		external
			"C struct struct EIF_WEL_USERDATA access object_id type EIF_INTEGER use %"disptchr.h%""
		end

	set_default_window_procedure (p: POINTER; proc: POINTER) is
			-- Set `default_window_procedure' from `p' with `proc'.
		external
			"C struct struct EIF_WEL_USERDATA access default_window_procedure type WNDPROC use %"disptchr.h%""
		end
		
end -- class WEL_INTERNAL_DATA
