indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.AssemblyViewDictionary"

class
	ASSEMBLY_VIEW_DICTIONARY
	
inherit
	VIEW_DICTIONARY
	
feature -- Access

	Caption_text: STRING is "Types"
		indexing
			description: "Text that appears in the blue header of the data grid"
			external_name: "CaptionText"
		end

	Data_table_title: STRING is "Types table"
		indexing
			description: "Data table title"
			external_name: "DataTableTitle"
		end
		
	Edit_type: STRING is "ISE Assembly Manager will now edit the selected type. This may take a few seconds. Please be patient."
		indexing
			description: "Message displayed to the user before opening the type view"
			external_name: "EditType"
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
		
	Title: STRING is "Assembly view"
		indexing
			description: "Window title"
			external_name: "Title"
		end

feature -- Columns names

	Eiffel_name_column_title: STRING is "Eiffel Name"
		indexing
			description: "Eiffel name column title"
			external_name: "EiffelNameColumnTitle"
		end

	External_name_column_title: STRING is "External Name"
		indexing
			description: "External name column title"
			external_name: "ExternalNameColumnTitle"
		end
		
end -- class ASSEMBLY_VIEW_DICTIONARY