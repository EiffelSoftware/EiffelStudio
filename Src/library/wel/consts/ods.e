indexing
	description: "Owner Draw State (ODS) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ODS_CONSTANTS

feature -- Access

	Ods_selected: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ODS_SELECTED"
		end

	Ods_grayed: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ODS_GRAYED"
		end

	Ods_disabled: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ODS_DISABLED"
		end

	Ods_checked: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ODS_CHECKED"
		end

	Ods_focus: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ODS_FOCUS"
		end

end -- class WEL_ODS_CONSTANTS

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
