note
	description: "Summary description for {CIL_METADATA_DISPENSER}."
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_MD_METADATA_DISPENSER


create
	make

feature -- Scope Definition

	make
			-- Create a new instance of METADATA_DISPENSER
		do
			create emit.make
		end



	emit: CIL_MD_METADATA_EMIT
		-- Emit metadata
end
