indexing
	description:
		"Simple test drivers for the console"
	legal: "See notice at end of class."

	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class SIMPLE_TEST_DRIVER

