indexing
	description:
		"Containers that provide index access"

	status:	"See note at end of class"
	author: "Patrick Schoenbach"
	date: "$Date$"
	revision: "$Revision$"

deferred class INDEXED_CONTAINER [G] inherit

	BASIC_CONTAINER [G]

feature -- Access

	item, infix "@" (i: INTEGER): G is
			-- `i'-th item
		require
			not_empty: not empty
			valid_index: valid_index (i)
		deferred
		ensure
			non_void_result: Result /= Void
		end

end -- class INDEXED_CONTAINER

--|----------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000 Interactive Software Engineering Inc.
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
