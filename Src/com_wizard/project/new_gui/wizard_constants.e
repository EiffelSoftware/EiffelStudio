indexing
	description: "Objects that provide access to constants loaded from files."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CONSTANTS

inherit
	WIZARD_CONSTANTS_IMP
		redefine
			icons_directory
		end

feature -- Access

	icons_directory: STRING is "resources"
			-- Icons directory
		
end -- class WIZARD_CONSTANTS
