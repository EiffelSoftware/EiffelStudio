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

	make (argv: ARRAY [STRING]) is
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

indexing

	library: "[
			EiffelTest: Library of reusable components for developping unit
			tests.
			]"

	status: "[
			Copyright 2000-2001 Interactive Software Engineering (ISE).
			]"

	license: "[
			EiffelTest may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class TEST_ROOT
