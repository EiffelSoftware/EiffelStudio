indexing
	description: "Path used both by conumser and assembly manager"

class
	COMMON_PATH

feature -- Access

	Classes_path: STRING is "classes\"
			-- Path to XML files from assembly directory

	Assembly_info_file_name: STRING is "types.xml"
			-- File which lists all types in assembly

end -- class COMMON_PATH
