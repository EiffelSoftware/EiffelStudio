indexing
	description: "To share an instance of IL_CASING_CONVERSION"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_IL_CASING

feature -- Access

	il_casing: IL_CASING_CONVERSION is
			-- Instance of IL_CASING_CONVERSION
		once
			create Result
		end
		
end -- class SHARED_IL_CASING
