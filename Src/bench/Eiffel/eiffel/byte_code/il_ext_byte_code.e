indexing
	description: "Encapsulation of an IL extension and no generation has to be done."
	date: "$Date$"
	revision: "$Revision$"

class IL_EXT_BYTE_CODE

inherit
	EXT_BYTE_CODE
		redefine
			generate
		end

feature -- Generation

	generate is
			-- Not applicable
		do
			check
				not_applicable: False
			end
		ensure then
			not_applicable: False
		end

end -- class IL_EXT_BYTE_CODE

