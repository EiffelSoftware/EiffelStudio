indexing
	description: "Useful strings"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	DICTIONARY

feature -- Access

	Comma: STRING is ","
		indexing
			description: "Comma as a string"
		end
		
	Dash: STRING is "-"
		indexing
			description: "Dash as a string"
		end
		
	Dot_string: STRING is "."
		indexing
			description: "Dot as a string"
		end

	DTD_extension: STRING is ".dtd"
		indexing
			description: "Extension of DTD file"
		end

	DTD_assembly_filename: STRING is "assembly_description"
		indexing
			description: "DTD file name for `assembly_description.xml'"
		end
		
	DTD_type_filename: STRING is "type"
		indexing
			description: "DTD file name for XML type description"
		end
		
	Empty_string: STRING is ""
		indexing
			description: "Empty string"
		end
		
	False_string: STRING is "False"
		indexing
			description: "False as a string"
		end

	Index_filename: STRING is "index"
		indexing
			description: "Filename of index containing names of all assemblies in the database"
		end

	Space: STRING is " "
		indexing
			description: "Space string"
		end
		
	True_string: STRING is "True"
		indexing
			description: "True as a string"
		end
	
	Xml_extension: STRING is ".xml"
		indexing	
			description: "Xml file extension"
		end

end -- class DICTIONARY