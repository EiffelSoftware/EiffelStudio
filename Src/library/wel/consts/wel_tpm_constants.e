indexing
	description: "TrackPopupMenu (TPM) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TPM_CONSTANTS

feature -- Access

	Tpm_leftbutton: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"TPM_LEFTBUTTON"
		end

	Tpm_rightbutton: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"TPM_RIGHTBUTTON"
		end

	Tpm_leftalign: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"TPM_LEFTALIGN"
		end

	Tpm_centeralign: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"TPM_CENTERALIGN"
		end

	Tpm_rightalign: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"TPM_RIGHTALIGN"
		end

end -- class WEL_TPM_CONSTANTS


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

