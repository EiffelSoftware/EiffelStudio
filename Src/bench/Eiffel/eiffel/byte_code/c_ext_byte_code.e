indexing
	description: "Encapsulation of a C extension and no generation has to be done."
	date: "$Date$"
	revision: "$Revision$"

class C_EXT_BYTE_CODE

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

end -- class C_EXT_BYTE_CODE
