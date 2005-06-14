indexing
	description: "Path used both by conumser and assembly manager"
	date: "$Date$"
	revision: "$Revision$"

class
	COMMON_PATH

feature -- Access

	Classes_file_name: STRING is "classes.info"
			-- Path to XML files from assembly directory

	Assembly_types_file_name: STRING is "types.info"
			-- File which lists all types in assembly

	Assembly_mapping_file_name: STRING is "referenced_assemblies.info"
			-- File which lists referenced assemblies with corresponding ids

end -- class COMMON_PATH
