indexing
	description: "Possible flags you can pass to `define_file' from `MD_ASSEMBLY_EMIT'"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_FILE_FLAGS

feature -- Access

	has_meta_data: INTEGER is 0
		-- This contains metadata.
	
	has_no_meta_data: INTEGER is 1
		-- This is a resource file or other non-metadata-containing file.

end -- class MD_FILE_FLAGS
