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
			"C [macro <wel.h>]"
		alias
			"TPM_LEFTBUTTON"
		end

	Tpm_rightbutton: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"TPM_RIGHTBUTTON"
		end

	Tpm_leftalign: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"TPM_LEFTALIGN"
		end

	Tpm_centeralign: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"TPM_CENTERALIGN"
		end

	Tpm_rightalign: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"TPM_RIGHTALIGN"
		end

end -- class WEL_TPM_CONSTANTS

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
