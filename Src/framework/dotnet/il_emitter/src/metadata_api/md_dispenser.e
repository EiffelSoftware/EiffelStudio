note
	description: "Summary description for {CIL_METADATA_DISPENSER}."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_DISPENSER

inherit
	MD_DISPENSER_I
		rename
			emitter as emit
		end
		
create
	make

feature -- Scope Definition

	make
			-- Create a new instance of METADATA_DISPENSER
		do
			create emit.make
		end

	emit: MD_EMIT
		-- Emit metadata
end
