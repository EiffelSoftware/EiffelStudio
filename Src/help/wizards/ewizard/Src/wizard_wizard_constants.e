indexing
	description	: "All constants used in the Wizard wizard"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_WIZARD_CONSTANTS

feature -- Initialization

	Interface_names: WIZARD_WIZARD_INTERFACE_NAMES is
			-- All string constants used in this wizard
		once
			create Result
		end

end -- class WIZARD_WIZARD_CONSTANTS
