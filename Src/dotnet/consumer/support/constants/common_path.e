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

	assembly_locations: LINKED_LIST [STRING] is
			-- List of assembly to consume.
		once
			create Result.make
		ensure
			non_void_assembly_locations: Result /= Void
		end


end -- class COMMON_PATH
