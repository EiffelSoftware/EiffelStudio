indexing
	description: "Set Character Format constants.";
	date: "$Date$";
	revision: "$Revision$"

class
	WEL_SCF_CONSTANTS

feature -- Access

	Scf_selection: INTEGER is 1
			-- Apply format to selection only.

	Scf_word: INTEGER is 2
			-- Apply format to word only.

	Scf_all: INTEGER is 4
			-- Apply format to all text.

end -- class WEL_SFC_CONSTANTS
