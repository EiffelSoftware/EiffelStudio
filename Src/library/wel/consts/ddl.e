indexing
	description: "Dialog Dir List (DDL) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DDL_CONSTANTS

feature -- Access

	Ddl_readwrite: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"DDL_READWRITE"
		end

	Ddl_readonly: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"DDL_READONLY"
		end

	Ddl_hidden: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"DDL_HIDDEN"
		end

	Ddl_system: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"DDL_SYSTEM"
		end

	Ddl_directory: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"DDL_DIRECTORY"
		end

	Ddl_archive: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"DDL_ARCHIVE"
		end

	Ddl_postmsgs: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"DDL_POSTMSGS"
		end

	Ddl_drives: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"DDL_DRIVES"
		end

	Ddl_exclusive: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"DDL_EXCLUSIVE"
		end

end -- class WEL_DDL_CONSTANTS

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
