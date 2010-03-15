note
	description: "Dialog Dir List (DDL) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DDL_CONSTANTS

feature -- Access

	Ddl_readwrite: INTEGER = 0

	Ddl_readonly: INTEGER = 1

	Ddl_hidden: INTEGER = 2

	Ddl_system: INTEGER = 4

	Ddl_directory: INTEGER = 16

	Ddl_archive: INTEGER = 32

	Ddl_postmsgs: INTEGER = 8192

	Ddl_drives: INTEGER = 16384

	Ddl_exclusive: INTEGER = 32768;

note
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

