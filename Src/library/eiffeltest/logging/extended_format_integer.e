indexing
	description:
		"Locally extended version of FORMAT_INTEGER"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class EXTENDED_FORMAT_INTEGER inherit

	FORMAT_INTEGER

create

	make, make_from_integer

feature {NONE} -- Initialization

	make_from_integer (n: INTEGER) is
			-- Create formatter whose width equals to the digits of `n'.
		do
			make (digits (n))
		ensure
			width_set: width = digits (n)
		end

feature {NONE} -- Implementation

	digits (n: INTEGER): INTEGER is
			-- Number of digits in `n'
		local
			d: INTEGER
		do
			from
				d := n
			until
				d = 0 or d = 1 or d = -1
			loop
				Result := Result + 1
				d := d // 10
			end
			if n <= 1 then Result := Result + 1 end
		ensure
			positive_result: Result > 0
		end

end -- class EXTENDED_FORMAT_INTEGER

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
