indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.DependancyDialogDictionary"

class
	DEPENDANCY_DIALOG_DICTIONARY

inherit
	DIALOG_DICTIONARY
	
feature -- Access

	Data_table_title: STRING is "Assemblies table"
		indexing
			description: "Data table title"
			external_name: "DataTableTitle"
		end
		
	Empty_string: STRING is ""
		indexing
			description: "Empty string"
			external_name: "EmptyString"
		end	

	Row_height: INTEGER is 20
		indexing
			description: "Height of rows in data grid"
			external_name: "RowHeight"
		end

	Scrollbar_width: INTEGER is 25
		indexing
			description: "Scrollbar width"
			external_name: "ScrollbarWidth"
		end
		
	System_string_type: STRING is "System.String"
		indexing
			description: "System.String type"
			external_name: "SystemStringType"
		end

	Window_height: INTEGER is 340
		indexing
			description: "Window height"
			external_name: "WindowHeight"
		end		

	Window_width: INTEGER is 660
		indexing
			description: "Window width"
			external_name: "WindowWidth"
		end

feature -- Columns names

	Assembly_name_column_title: STRING is "Name"
		indexing
			description: "Assembly name column title"
			external_name: "AssemblyNameColumnTitle"
		end

	Assembly_version_column_title: STRING is "Version"
		indexing
			description: "Assembly version column title"
			external_name: "AssemblyVersionColumnTitle"
		end
		
	Assembly_culture_column_title: STRING is "Culture"
		indexing
			description: "Assembly culture column title"
			external_name: "AssemblyCultureColumnTitle"
		end

	Assembly_public_key_column_title: STRING is "Public Key"
		indexing
			description: "Assembly public key column title"
			external_name: "AssemblyPublicKeyColumnTitle"
		end
		
end -- class DEPENDANCY_DIALOG_DICTIONARY
