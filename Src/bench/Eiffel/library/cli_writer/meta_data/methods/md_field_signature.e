indexing
	description: "Represent a field signature both for definition."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_FIELD_SIGNATURE

inherit
	MD_SIGNATURE
		rename
			make as old_make
		end
	
create
	make
	
feature {NONE} -- Initialization

	make is
			-- Initialize current.
		do
			old_make
			internal_put (feature {MD_SIGNATURE_CONSTANTS}.field, 0)
			current_position := current_position + 1
		end

end -- class MD_FIELD_SIGNATURE
