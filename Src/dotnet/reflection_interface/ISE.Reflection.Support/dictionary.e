indexing
	description: "Useful strings"
	external_name: "ISE.Reflection.Dictionary"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	DICTIONARY

feature -- Access

	Comma: STRING is ","
			-- Comma string
		indexing
			external_name: "Comma"
		end
		
	Dash: STRING is "-"
			-- Dash as a string
		indexing
			external_name: "Dash"
		end
		
	Dot_string: STRING is "."
			-- Dot as a string
		indexing
			external_name: "DotString"
		end

	DTD_extension: STRING is ".dtd"
			-- Extension of DTD file
		indexing
			external_name: "DtdExtension"
		end

	DTD_assembly_filename: STRING is "assembly_description"
			-- DTD file name
		indexing
			external_name: "DtdAssemblyFilename"
		end
		
	DTD_type_filename: STRING is "type"
			-- DTD file name
		indexing
			external_name: "DtdTypeFilename"
		end
		
	Empty_string: STRING is ""
			-- Empty string
		indexing
			external_name: "EmptyString"
		end
		
	False_string: STRING is "False"
			--False as a string
		indexing
			external_name: "FalseString"
		end

	Index_filename: STRING is "index"
			-- Filename of index containing names of all assemblies in the database
		indexing
			external_name: "IndexFilename"
		end

	Space: STRING is " "
			-- Space string
		indexing
			external_name: "Space"
		end
		
	True_string: STRING is "True"
			--True as a string
		indexing
			external_name: "TrueString"
		end
	
	Xml_extension: STRING is ".xml"
			-- Xml file extension
		indexing
			external_name: "XmlExtension"
		end

end -- class DICTIONARY