indexing
	description:
		"[
			Low-level string class used to solve GC problems (object move).
			The end-user must not use this class, use STRING instead.
		]"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	GEL_STRING

inherit
	MEMORY
		redefine
			dispose
		end

create
	make

feature {NONE} -- Initialization

	make (a_string: STRING) is
			-- Make a C string from `a_string'.
		require
			a_string_not_void: a_string /= Void
		local
			a: ANY
			nb: INTEGER
			a_default_pointer: POINTER
		do
			nb := a_string.count
			item := a_default_pointer.memory_alloc (nb + 1)
			if item = default_pointer then
				--| FIXME Raise exception
			end
			a := a_string.to_c
			item.memory_copy ($a, nb + 1)
		end
		
feature -- Access
		
	item: POINTER
	
feature {NONE} -- Implementation

	dispose is
			-- 
		do
			item.memory_free
		end	

end -- class GEL_STRING

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

