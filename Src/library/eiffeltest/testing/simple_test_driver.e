indexing
	description:
		"Simple test drivers for the console"

	status:	"See note at end of class"
	author: "Patrick Schoenbach"
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
