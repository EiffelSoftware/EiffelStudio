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

	Ods_default: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ODS_DEFAULT"
		end

	Ods_comboboxedit: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ODS_COMBOBOXEDIT"
		end

end -- class WEL_ODS_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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

