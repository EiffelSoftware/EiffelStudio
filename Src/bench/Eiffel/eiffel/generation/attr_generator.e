indexing
	description: "Generator of attribute offset tables"
	date: "$Date$"
	revision: "$Revision$"

class ATTR_GENERATOR 

inherit
	TABLE_GENERATOR
		rename
			Dot_x as postfix_file_name
		end

feature -- Initialzation

	init_file (file: INDENT_FILE) is
			-- Initialization of new file
		do
				-- Let's finish C code generation of current block.
			current_buffer.end_c_specific_code

			file.put_string ("#include %"eif_macros.h%"%N%N")
		end

end
