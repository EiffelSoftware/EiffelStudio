indexing
	description: "Useful strings"
	external_name: "ISE.Reflection.Dictionary"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	DICTIONARY

feature -- Access

	Comma: STRING is ","
		indexing
			description: "Comma as a string"
			external_name: "Comma"
		end
		
	Dash: STRING is "-"
		indexing
			description: "Dash as a string"
			external_name: "Dash"
		end
		
	Dot_string: STRING is "."
		indexing
			description: "Dot as a string"
			external_name: "DotString"
		end

	DTD_extension: STRING is ".dtd"
		indexing
			description: "Extension of DTD file"
			external_name: "DtdExtension"
		end

	DTD_assembly_filename: STRING is "assembly_description"
		indexing
			description: "DTD file name for `assembly_description.xml'"
			external_name: "DtdAssemblyFilename"
		end
		
	DTD_type_filename: STRING is "type"
		indexing
			description: "DTD file name for XML type description"
			external_name: "DtdTypeFilename"
		end
		
	Empty_string: STRING is ""
		indexing
			description: "Empty string"
			external_name: "EmptyString"
		end
		
	False_string: STRING is "False"
		indexing
			description: "False as a string"
			external_name: "FalseString"
		end

	Index_filename: STRING is "index"
		indexing
			description: "Filename of index containing names of all assemblies in the database"
			external_name: "IndexFilename"
		end

	Space: STRING is " "
		indexing
			description: "Space string"
			external_name: "Space"
		end
		
	True_string: STRING is "True"
		indexing
			description: "True as a string"
			external_name: "TrueString"
		end
	
	Xml_extension: STRING is ".xml"
		indexing	
			description: "Xml file extension"
			external_name: "XmlExtension"
		end

end -- class DICTIONARY