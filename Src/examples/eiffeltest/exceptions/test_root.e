indexing
	description:
		"Root class for validity test"

	status:	"See note at end of class"
	author: "Patrick Schoenbach"
	date: "$Date$"
	revision: "$Revision$"

class 
	TEST_ROOT

create

	make

feature {NONE} -- Initialization

	make (argv: ARRAY[STRING]) is
			-- Create test.
		local
			log: SCREEN_LOG
			drv: SIMPLE_TEST_DRIVER
			t: EXCEPTION_TEST
		do
			create log.make
			log.set_format ("ascii")
			create drv.make (log)
			create t.make
			drv.enable_timing_display
			drv.extend (t)
			drv.execute
			drv.evaluate
		end

end -- class TEST_ROOT

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
