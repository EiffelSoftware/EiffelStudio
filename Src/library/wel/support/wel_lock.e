indexing
	description: "Objects that provide access to memory lock functions."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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




end -- class WEL_LOCK

