indexing
	description:
		"Containers that provide index access"

	status:	"See note at end of class"
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
--| Copyright (C) 2000 Interactive Software Engineering Inc (ISE).
--| EiffelTest may be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
