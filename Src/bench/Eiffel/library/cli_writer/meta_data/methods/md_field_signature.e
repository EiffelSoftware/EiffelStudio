indexing
	description: "Representation a field signature used for defining a field."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_FIELD_SIGNATURE

inherit
	MD_SIGNATURE
		redefine
			make
		end
	
create
	make
	
feature {NONE} -- Initialization

	make is
			-- Initialize current.
		do
			Precursor {MD_SIGNATURE}
			internal_put (feature {MD_SIGNATURE_CONSTANTS}.field_sig, 0)
			current_position := 1
		ensure then
			current_position_set: current_position = 1
		end

feature -- Reset

	reset is
			-- Reset content.
		do
			internal_put (feature {MD_SIGNATURE_CONSTANTS}.field_sig, 0)
			current_position := 1
		ensure
			current_position_set: current_position = 1
		end
		
end -- class MD_FIELD_SIGNATURE
