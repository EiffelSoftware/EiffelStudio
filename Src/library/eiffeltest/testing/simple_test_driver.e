indexing
	description:
		"Simple test drivers for the console"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class SIMPLE_TEST_DRIVER inherit

	TEST_DRIVER
		rename
			make as driver_make
		end

create

	make

feature {NONE} -- Initialization

	make (f: LOG_FACILITY) is
			-- Create driver with log output to `f'.
		require
			log_exists: f /= Void
			log_format: f.is_format_set
		do
			driver_make (0)
			set_log (f)
			set_standard_output (Io.error)
		ensure
			log_set: log = f
			standard_output_set: has_standard_output
		end

end -- class SIMPLE_TEST_DRIVER

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
