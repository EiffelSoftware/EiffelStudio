indexing
	description:
		"Facility to access a standard output medium"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	STANDARD_OUTPUT_FACILITY

feature -- Status report

	has_standard_output: BOOLEAN is
			-- Has a standard output been set?
		do
			Result := (standard_output /= Void)
		end
		
feature -- Status setting

	set_standard_output (o: IO_MEDIUM) is
			-- Set standard output to `o'.
		do
			standard_output := o
		ensure
			medium_set: standard_output = o
		end
		
feature {NONE} -- Implementation

	standard_output: IO_MEDIUM
			-- Standard output medium

end -- class STANDARD_OUTPUT_FACILITY

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
