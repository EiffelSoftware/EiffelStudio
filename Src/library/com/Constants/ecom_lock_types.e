indexing

	description: "IStorage and Istream lock types flags"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	ECOM_LOCK_TYPES

feature -- Access

	Lock_write: INTEGER is
			-- If lock is granted, specified region of stream
			-- can be read by calling IStream.Read from any opening of
			-- this stream. Attempts to write to this region from any opening
			-- of this stream other than the one to which lock was granted
			-- returns error EOLE_STG_E_ACCESSDENIED.
		external
			"C [macro <objidl.h>]"
		alias
			"LOCK_WRITE"
		end
		
	Lock_exclusive: INTEGER is
			-- Attempts to read or write this stream by other stream openings
			-- return error EOLE_STG_E_ACCESSDENIED.
		external
			"C [macro <objidl.h>]"
		alias
			"LOCK_EXCLUSIVE"
		end
		
	Lock_onlyonce: INTEGER is
			-- If lock is granted, no other EOLE_LOCK_ONLYONCE lock can be
			-- obtained on bytes in given region. Usually this lock type
			-- is an alias for some other lock type and other semantics might occur
			-- as a side effect.
		external
			"C [macro <objidl.h>]"
		alias
			"LOCK_ONLYONCE"
		end

	is_valid_lock (lock: INTEGER): BOOLEAN is
			-- Is `lock' a valid locktype?
		do
			Result := lock = Lock_write or
						lock = Lock_exclusive or
						lock = Lock_onlyonce
		end
		
end -- class EOLE_LOCKTYPES

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

