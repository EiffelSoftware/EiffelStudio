indexing
	description: "Encapsulation of an IL extension and no generation has to be done."
	date: "$Date$"
	revision: "$Revision$"

class IL_EXT_BYTE_CODE

inherit
	EXT_EXT_BYTE_CODE
		redefine
			generate_signature, generate_body
		end

feature -- Generation

	generate_signature is
		do
		end

	generate_body is
		do
		end

end -- class IL_EXT_BYTE_CODE

