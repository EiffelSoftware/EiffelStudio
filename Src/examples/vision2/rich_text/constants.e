indexing
	description: "Objects that provide access to constants loaded from files."
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTANTS

inherit
	CONSTANTS_IMP
			redefine
				rich_text_example_root
			end

feature -- Access

	rich_text_example_root: STRING is
			-- Root directory for rich text example. As all pixmaps
			-- are in root directory, we use "." for current directory.
		do
			Result := "."
		end

end -- class CONSTANTS
