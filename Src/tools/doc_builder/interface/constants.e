indexing
	description: "Objects that provide access to constants loaded from files."
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTANTS

inherit
	CONSTANTS_IMP
		redefine
			pixmap_directory
		end
		
feature -- Access

	pixmap_directory: STRING is
			-- `Result' is DIRECTORY constant named `pixmap_directory'.
		once
			Result := (create {APPLICATION_CONSTANTS}).icon_resources_directory
		end
	
end -- class CONSTANTS
