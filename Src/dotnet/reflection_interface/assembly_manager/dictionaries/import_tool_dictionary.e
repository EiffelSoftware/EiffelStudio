indexing
	description: "Useful constants for import tool"
	external_name: "ISE.AssemblyManager.ImportToolDictionary"

class
	IMPORT_TOOL_DICTIONARY

inherit
	ASSEMBLY_VIEWER_DICTIONARY

feature -- Menu items

	Open_menu_item: STRING is "&Open Assembly"
		indexing
			description: "Text of open menu item"
			external_name: "ShowOpenMenuItem"
		end
		
	Show_name_menu_item: STRING is "&Show name only"
		indexing
			description: "Text of show name menu item"
			external_name: "ShowNameMenuItem"
		end
		
	Import_menu_item: STRING is "&Import"
		indexing
			description: "Text of import menu item"
			external_name: "ImportToolMenuItem"
		end

feature -- Shortcuts

	Ctrl_O_shortcut: INTEGER is 131151
		indexing
			description: "Ctrl+O shortcut, enum value: 0x 2004F"
			external_name: "CtrlOShortcut"
		end
		
feature -- Error messages

	Error_browsing_GAC: STRING is "An error occurred while retrieving assemblies from the GAC."
		indexing
			description: "Error message when an error occurs when browsing assemblies in the GAC"
			external_name: "ErrorBrowsingGac"
		end
		
	Non_signed_assembly: STRING is "The selected assembly is not signed. Please sign it before using ISE Assembly Manager."		
		indexing
			description: "Error message when user selects a non-signed assembly."
			external_name: "NonSignedAssembly"
		end
		
feature -- Open file dialog constants	
	
	Open_file_dialog_title: STRING is "Browse for a .NET assembly"
		indexing
			description: "Title of open file dialog"
			external_name: "OpenFileDialogTitle"
		end
		
	Open_file_dialog_filter: STRING is ".NET assembly (*.dll)|*.dll|.NET assembly (*.exe)|*.exe"
		indexing
			description: "Filter of open file dialog"
			external_name: "OpenFileDialogFilter"
		end
		
	Ok_returned_value: INTEGER is 1
		indexing
			description: "Value returned when user clicks on `OK' in the open file dialog"
			external_name: "OkReturnedValue"
		end

feature -- Toolbar icons filename

	Open_icon_filename: STRING is 
		indexing
			description: "Filename of icon on open toolbar button"
			external_name: "ShowOpenIconFilename"
		once
			Result := base_filename
			Result := Result.concat_string_string (Result,Open_icon_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: Result.length > 0			
		end
		
	Import_icon_filename: STRING is 
		indexing
			description: "Filename of icon on import toolbar button"
			external_name: "ImportIconFilename"
		once
			Result := base_filename
			Result := Result.concat_string_string (Result, Import_icon_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: Result.length > 0			
		end

	Import_tool_icon_filename: STRING is 
		indexing
			description: "Filename of icon appearing in import tool header"
			external_name: "ImportToolIconFilename"
		once
			Result := Base_filename
			Result := Result.concat_string_string (Result, Import_tool_icon_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: Result.length > 0
		end
		
feature -- Other constants

	Caption_text: STRING is "Shared Assemblies"
		indexing
			description: "Text that appears in the blue header of the data grid"
			external_name: "CaptionText"
		end

	Import_tool_icon: SYSTEM_DRAWING_ICON is
		indexing
			description: "Icon appearing in import tool header"
			external_name: "ImportToolIcon"
		once
			create Result.make_icon (Import_tool_icon_filename)
		ensure
			icon_created: Result /= Void
		end

feature {NONE} -- Implementation

	Open_icon_relative_filename: STRING is "icon_open_file_color.ico"
		indexing
			description: "Filename of icon on open toolbar button"
			external_name: "ShowOpenIconRelativeFilename"
		end
		
	Import_icon_relative_filename: STRING is "icon_import_assembly_color.ico"
		indexing
			description: "Filename of icon on import toolbar button"
			external_name: "ImportIconRelativeFilename"
		end

	Import_tool_icon_relative_filename: STRING is "\icon_import_tool_title_color.ico"
		indexing
			description: "Filename of icon appearing in import tool header"
			external_name: "ImportToolIconRelativeFilename"
		end
		
end -- class IMPORT_TOOL_DICTIONARY	
