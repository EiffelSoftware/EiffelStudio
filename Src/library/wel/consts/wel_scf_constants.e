indexing
	description: "Set Character Format constants.";
	date: "$Date$";
	revision: "$Revision$"

class
	WEL_SCF_CONSTANTS

feature -- Access

	Scf_all: INTEGER is
			-- Apply format to all text.
		external
			"C [macro %"redit.h%"]"
		alias
			"SCF_ALL"
		end

	Scf_selection: INTEGER is
			-- Apply format to selection only.
		external
			"C [macro %"redit.h%"]"
		alias
			"SCF_SELECTION"
		end

	Scf_word: INTEGER is
			-- Apply format to word only.
		external
			"C [macro %"redit.h%"]"
		alias
			"SCF_WORD"
		end

end -- class WEL_SFC_CONSTANTS
