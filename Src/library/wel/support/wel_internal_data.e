indexing
	description: "Small wrapper around the EIF_WEL_USERDATA C structure."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_INTERNAL_DATA

