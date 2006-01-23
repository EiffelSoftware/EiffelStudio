indexing
	description: "Set Character Format constants."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	WEL_SCF_CONSTANTS

feature -- Access

	Scf_selection: INTEGER is 1
			-- Apply format to selection only.

	Scf_word: INTEGER is 2
			-- Apply format to word only.

	Scf_all: INTEGER is 4;
			-- Apply format to all text.

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




end -- class WEL_SFC_CONSTANTS

