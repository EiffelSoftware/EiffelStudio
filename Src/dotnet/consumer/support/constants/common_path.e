indexing
	description: "Path used both by conumser and assembly manager"
	date: "$Date$"
	revision: "$Revision$"

class
	COMMON_PATH

feature -- Access

	Classes_path: STRING is "classes\"
			-- Path to XML files from assembly directory

	Assembly_types_file_name: STRING is "types.xml"
			-- File which lists all types in assembly

	Assembly_mapping_file_name: STRING is "referenced_assemblies.xml"
			-- File which lists referenced assemblies with corresponding ids

end -- class COMMON_PATH
