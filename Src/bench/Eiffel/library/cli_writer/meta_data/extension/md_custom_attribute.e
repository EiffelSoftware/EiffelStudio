indexing
	description: "Representation of a custom attribute blob as specified in Partition II 22.3."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_CUSTOM_ATTRIBUTE

inherit
	MD_SIGNATURE
		rename
			set_type as add_local_type
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
			item.put_integer_16 (feature {MD_SIGNATURE_CONSTANTS}.Ca_prolog, 0)
			current_position := 2
		ensure then
			current_position_set: current_position = 2
		end

end -- class MD_CUSTOM_ATTRIBUTE
