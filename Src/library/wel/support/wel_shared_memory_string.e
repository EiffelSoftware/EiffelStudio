indexing
	description: "Represents windows shared memory"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SHARED_MEMORY_STRING

inherit
	WEL_SHARED_MEMORY

create
	make_from_handle,
	make_from_string

feature -- Initialization

	make_from_string (a_string: STRING) is
		-- Create `Current' from `a_string'.
	do
		make_from_handle (global_alloc (gmem_moveable, a_string.count + 1))
		lock
		item.memory_copy ((create {WEL_STRING}.make (a_string)).item,
			a_string.count + 1)
		unlock
	end	

feature -- Access

	last_string: STRING
			-- String created from shared memory.
			-- Only valid after a call to `retrieve_string'
			-- Note: Changes to this object will not be
			-- reflected in the shared memory
				
feature -- Element change

	retrieve_string is
		do
			lock
			check
				memory_locked: accessible
			end
			create last_string.make (0)
			last_string.from_c (item)				
			unlock		
		end

end -- class WEL_SHARED_MEMORY

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

