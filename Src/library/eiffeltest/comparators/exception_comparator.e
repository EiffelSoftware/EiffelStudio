indexing
	description:
		"Comparators for `is_assertion_exception' on RESULT_RECORD"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class EXCEPTION_COMPARATOR inherit

	COMPARATOR
		rename
			is_true as is_assertion_exception
		redefine
			callback
		end

create

	make
	
feature -- Status report

	is_assertion_exception (n: INTEGER): BOOLEAN is
			-- Is assertion `n' an exception?
		do
			Result := callback.is_assertion_exception (n)
		end

feature {NONE} -- Implementation

	callback: CASE_RESULT_RECORD [ASSERTION_RESULT]
			-- Reference to callback object


end -- class EXCEPTION_COMPARATOR

--|----------------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000-2001 Interactive Software Engineering Inc (ISE).
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
--|----------------------------------------------------------------------
