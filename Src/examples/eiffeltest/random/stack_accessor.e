indexing
	description:
		"Accessor facility for stacks"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class STACK_ACCESSOR [G] inherit

	FIXTURE_ACCESSOR
		rename
			fixture as stack
		redefine
			stack
		end

feature -- Access

	stack: STACK [G] is
			-- Stack accessor
		do
			Result ?= Precursor
		end

end -- class STACK_ACCESSOR

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
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------------
