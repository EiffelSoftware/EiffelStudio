indexing
	description: "Dialog response (ID) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ID_CONSTANTS

feature -- Access

	Idok: INTEGER is
			-- OK button was selected.
		external
			"C [macro %"wel.h%"]"
		alias
			"IDOK"
		end

	Idcancel: INTEGER is
			-- Cancel button was selected.
		external
			"C [macro %"wel.h%"]"
		alias
			"IDCANCEL"
		end

	Idabort: INTEGER is
			-- Abort button was selected.
		external
			"C [macro %"wel.h%"]"
		alias
			"IDABORT"
		end

	Idretry: INTEGER is
			-- Retry button was selected.
		external
			"C [macro %"wel.h%"]"
		alias
			"IDRETRY"
		end

	Idignore: INTEGER is
			-- Ignore button was selected.
		external
			"C [macro %"wel.h%"]"
		alias
			"IDIGNORE"
		end

	Idyes: INTEGER is
			-- Yes button was selected.
		external
			"C [macro %"wel.h%"]"
		alias
			"IDYES"
		end

	Idno: INTEGER is
			-- No button was selected.
		external
			"C [macro %"wel.h%"]"
		alias
			"IDNO"
		end

end -- class WEL_ID_CONSTANTS

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

