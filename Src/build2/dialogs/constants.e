indexing
	description: "Objects that provide access to constants loaded from files."
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTANTS

inherit
	CONSTANTS_IMP
		redefine
			png_location
		end

-- Perform any constant redefinitions in this class.

feature -- Access

	png_location: STRING is
			-- `Result' is DIRECTORY constant named `png_location'.
		once
			Result := (create {GB_SHARED_PIXMAPS}).png_location
		end
	
end -- class CONSTANTS
