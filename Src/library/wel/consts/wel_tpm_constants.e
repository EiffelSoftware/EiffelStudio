indexing
	description: "TrackPopupMenu (TPM) constants."
	legal: "See notice at end of class."
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




end -- class WEL_TPM_CONSTANTS

