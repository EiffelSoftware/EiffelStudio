indexing
	description: "Encapsulation of a C extension.";
	date: "$Date$";
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

feature -- Properties

	special_file_name: STRING
			-- Special file name (dll or macro)

feature -- Initialization

	set_special_file_name (f: STRING) is
			-- Assign `f' to `special_file_name'.
		do
			special_file_name := f
		end

end -- class C_EXT_BYTE_CODE
