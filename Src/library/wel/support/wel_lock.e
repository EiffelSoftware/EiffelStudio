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
