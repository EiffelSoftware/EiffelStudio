indexing
	description:
		"Root class for validity test"

	status:	"See note at end of class"
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
			reader: TEST_DATA_READER [VALIDITY_TEST]
			col: DATE_COLUMN
			f: PLAIN_TEXT_FILE
			s: TEST_SUITE
			drv: SIMPLE_TEST_DRIVER
		do
			create log.make
			log.set_format ("ascii")
			if argv.count /= 2 then
				Io.error.put_string ("Please specify test data file!%N")
			else
				create f.make (argv.item (1))
				if not f.exists or else not f.is_readable then
					Io.error.put_string ("Cannot open file!%N")
				else
					create reader.make_with_result_column (f, 1)
					create col
					reader.set_column (col, 1)
					reader.set_log (log)
					reader.build_suite
					if reader.is_suite_generated then
						s := reader.suite
						create drv.make (log)
						drv.enable_timing_display
						drv.extend (s)
						drv.execute
						drv.evaluate
					else
						Io.error.put_string ("No test suite generated!%N")
					end
				end
			end
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
