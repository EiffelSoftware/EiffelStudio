indexing
	description: "Constants used with CLI_SECTION_HEADER"
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_SECTION_CONSTANTS

feature -- Access

	code: INTEGER is 0x00000020
			-- Section contains code.

	initialized_data: INTEGER is 0x00000040
			-- Section contains initialized data.

	uninitialized_data: INTEGER is 0x00000080
			-- Section contains uninitialized data.

	execute: INTEGER is 0x20000000
			-- Section is executable.

	read: INTEGER is 0x40000000
			-- Section is readable.

	write: INTEGER is 0x80000000
			-- Section is writable.

end -- class CLI_SECTION_CONSTANTS
