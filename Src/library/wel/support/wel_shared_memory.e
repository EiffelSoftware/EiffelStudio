indexing
	description: "Represents windows shared memory"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_SHARED_MEMORY

inherit
	WEL_ANY

feature {NONE} -- Initialisation
	
	make_from_handle (a_handle: POINTER) is
			-- Set `handle' with `a_handle'.
			-- Since `item' is shared, it does not need
			-- to be freed.
		do
			handle := a_handle
			shared := True
		ensure
			handle_set: handle = a_handle
			shared: shared
		end


feature -- Access

	accessible: BOOLEAN
			-- Is the memory (`memory_item') locked and thus can be accessed?

	handle: POINTER
			-- Handle of access shared memory		
			
feature -- Status report

	size: INTEGER is
		do
			Result := global_size (handle)
		end
	
feature -- Element change

	lock is
			-- Locks the memory and returns a pointer to the actual data
		do
			item := global_lock (handle)
			if
				item /= default_pointer
			then
				accessible := True
			end
		end

	unlock is
			-- Unlocks the memory
		local
			b_result: BOOLEAN
		do
			b_result := global_unlock (handle)
			accessible := False
		end

feature {NONE} -- Implementation

	destroy_item is
			-- Do nothing, because we have not created the shared
			-- memory.
		local
			p_result: POINTER
		do
			p_result := global_free (handle)			
			check
				destroyed: p_result = default_pointer
			end
		end

feature {NONE} -- Externals

	global_lock (a_handle: POINTER): POINTER is
		external
			"C [macro %"wel.h%"]"
		alias
			"GlobalLock"
		end

	global_unlock (a_handle: POINTER): BOOLEAN is
		external
			"C [macro %"wel.h%"]"
		alias
			"GlobalUnlock"
		end

	global_size (a_handle: POINTER): INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"GlobalSize"
		end

	global_free (a_handle: POINTER): POINTER is
		external
			"C [macro %"wel.h%"]"
		alias
			"GlobalFree"
		end

	global_alloc (flags, bytes: INTEGER): POINTER is
		external
			"C [macro %"wel.h%"]"
		alias
			"GlobalAlloc"
		end

	gmem_moveable: INTEGER is
		external
			"C [macro %"windows.h%"]"
		alias
			"GMEM_MOVEABLE"
		end

end -- class WEL_SHARED_MEMORY

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

