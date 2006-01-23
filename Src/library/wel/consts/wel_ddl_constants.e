indexing
	description: "Dialog Dir List (DDL) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DDL_CONSTANTS

feature -- Access

	Ddl_readwrite: INTEGER is 0

	Ddl_readonly: INTEGER is 1

	Ddl_hidden: INTEGER is 2

	Ddl_system: INTEGER is 4

	Ddl_directory: INTEGER is 16

	Ddl_archive: INTEGER is 32

	Ddl_postmsgs: INTEGER is 8192

	Ddl_drives: INTEGER is 16384

	Ddl_exclusive: INTEGER is 32768;

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




end -- class WEL_DDL_CONSTANTS

