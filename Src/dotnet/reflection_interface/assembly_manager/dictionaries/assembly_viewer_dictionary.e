indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.AssemblyViewerDictionary"

class
	ASSEMBLY_VIEWER_DICTIONARY

inherit
	DICTIONARY

feature -- Menu items

	File_menu_item: STRING is "&File"
		indexing
			description: "Text of file menu item"
			external_name: "FileMenuItem"
		end
	
	Exit_menu_item: STRING is "E&xit"
		indexing
			description: "Text of exit menu item"
			external_name: "ExitMenuItem"
		end	
	
	View_menu_item: STRING is "&View"
		indexing
			description: "Text of view menu item"
			external_name: "ViewMenuItem"
		end
		
	Name_menu_item: STRING is "Assembly &Name"	
		indexing
			description: "Text of assembly name menu item"
			external_name: "NameMenuItem"
		end
		
	Version_menu_item: STRING is "Assembly &Version"
		indexing
			description: "Text of assembly version menu item"
			external_name: "VersionMenuItem"
		end

	Culture_menu_item: STRING is "Assembly &Culture"
		indexing
			description: "Text of assembly culture menu item"
			external_name: "CultureMenuItem"
		end
		
	Public_key_menu_item: STRING is "Assembly Public &Key"
		indexing
			description: "Text of assembly public key menu item"
			external_name: "PublicKeyMenuItem"
		end
		
	Dependancies_menu_item: STRING is "&Dependencies"
		indexing
			description: "Text of dependancies menu item"
			external_name: "DependanciesMenuItem"
		end
		
	Show_all_menu_item: STRING is "Show &All"	
		indexing
			description: "Text of `show all' menu item"
			external_name: "ShowAllMenuItem"
		end
		
	Tools_menu_item: STRING is "&Tools"
		indexing
			description: "Text of tools menu item"
			external_name: "ToolsMenuItem"
		end

	dependancy_viewer_menu_item: STRING is "&Dependency Viewer"
		indexing
			description: "Text of `dependency viewer' menu item"
			external_name: "DependancyViewerMenuItem"
		end
		
	Help_menu_item: STRING is "&Help"
		indexing
			description: "Text of help menu item"
			external_name: "HelpMenuItem"
		end
		
	Help_topics_menu_item: STRING is "&Help Topics"
		indexing
			description: "Text of help topics menu item"
			external_name: "HelpTopicsMenuItem"
		end
		
	About_menu_item: STRING is "&About ISE Assembly Manager"
		indexing
			description: "Text of about ISE assembly manager menu item"
			external_name: "AboutMenuItem"
		end

feature -- Error messages

	Error_message: STRING is "An internal error has occurred. Please start ISE Assembly Manager again."
		indexing
			description: "Error message when an imprecise error occurs in ISE assembly manager"
			external_name: "ErrorMessage"
		end

	Toolbar_icon_not_found_error: STRING is "A toolbar icon was not found. Please reinstall your Eiffel delivery."
		indexing
			description: "Error message in case a toolbar icon has not been found"
			external_name: "ToolbarIconNotFoundError"
		end
		
feature -- Toolbar icons filename
	
	Name_icon_filename: STRING is 
		indexing
			description: "Filename of icon on name toolbar button"
			external_name: "NameIconFilename"
		once
			Result := base_filename
			Result := Result.concat_string_string (Result, Name_icon_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: Result.get_length > 0
		end
		
	Version_icon_filename: STRING is 
		indexing
			description: "Filename of icon on version toolbar button"
			external_name: "VersionIconFilename"
		once
			Result := base_filename
			Result := Result.concat_string_string (Result, Version_icon_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: Result.get_length > 0
		end

	Culture_icon_filename: STRING is 
		indexing
			description: "Filename of icon on culture toolbar button"
			external_name: "CultureIconFilename"
		once
			Result := base_filename
			Result := Result.concat_string_string (Result, Culture_icon_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: Result.get_length > 0
		end
		
	Public_key_icon_filename: STRING is 
		indexing
			description: "Filename of icon on public key toolbar button"
			external_name: "PublicKeyIconFilename"
		once
			Result := base_filename
			Result := Result.concat_string_string (Result, Public_key_icon_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: Result.get_length > 0
		end
		
	Dependancies_icon_filename: STRING is 
		indexing
			description: "Filename of icon on dependancies toolbar button"
			external_name: "DependanciesIconFilename"
		once
			Result := base_filename
			Result := Result.concat_string_string (Result, Dependancies_icon_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: Result.get_length > 0
		end

	Dependancy_viewer_icon_filename: STRING is 
		indexing
			description: "Filename of icon on dependancy viewer toolbar button"
			external_name: "DependancyViewerIconFilename"
		once
			Result := base_filename
			Result := Result.concat_string_string (Result, Dependancy_viewer_icon_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: Result.get_length > 0
		end
						
	Help_icon_filename: STRING is 
		indexing
			description: "Filename of icon on help toolbar button"
			external_name: "HelpIconFilename"
		once
			Result := base_filename
			Result := Result.concat_string_string (Result, Help_icon_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: Result.get_length > 0
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

	Dependancies_column_title: STRING is "Dependencies"
		indexing
			description: "Dependancies column title"
			external_name: "DependanciesColumnTitle"
		end	

feature -- Error messages

	Name_icon_not_found_error: STRING is
		indexing
			description: "Error message in case the name toolbar icon has not been found"
			external_name: "NameIconNotFoundError"
		once
			Result ?= Pixmap_not_found_error_part_1.clone
			Result := Result.concat_string_string_string (Result, Name_icon_filename, Pixmap_not_found_error_part_2)
		ensure
			non_void_message: Result /= Void
			not_empty_message: Result.get_length > 0
		end

	Version_icon_not_found_error: STRING is
		indexing
			description: "Error message in case the version toolbar icon has not been found"
			external_name: "VersionIconNotFoundError"
		once
			Result ?= Pixmap_not_found_error_part_1.clone
			Result := Result.concat_string_string_string (Result, Version_icon_filename, Pixmap_not_found_error_part_2)
		ensure
			non_void_message: Result /= Void
			not_empty_message: Result.get_length > 0
		end

	Culture_icon_not_found_error: STRING is
		indexing
			description: "Error message in case the culture toolbar icon has not been found"
			external_name: "CultureIconNotFoundError"
		once
			Result ?= Pixmap_not_found_error_part_1.clone
			Result := Result.concat_string_string_string (Result, Culture_icon_filename, Pixmap_not_found_error_part_2)
		ensure
			non_void_message: Result /= Void
			not_empty_message: Result.get_length > 0
		end

	Public_key_icon_not_found_error: STRING is
		indexing
			description: "Error message in case the public key toolbar icon has not been found"
			external_name: "PublicKeyIconNotFoundError"
		once
			Result ?= Pixmap_not_found_error_part_1.clone
			Result := Result.concat_string_string_string (Result, Public_key_icon_filename, Pixmap_not_found_error_part_2)
		ensure
			non_void_message: Result /= Void
			not_empty_message: Result.get_length > 0
		end

	Dependencies_icon_not_found_error: STRING is
		indexing
			description: "Error message in case the dependencies toolbar icon has not been found"
			external_name: "DependenciesIconNotFoundError"
		once
			Result ?= Pixmap_not_found_error_part_1.clone
			Result := Result.concat_string_string_string (Result, Dependancies_icon_filename, Pixmap_not_found_error_part_2)
		ensure
			non_void_message: Result /= Void
			not_empty_message: Result.get_length > 0
		end

	Dependency_icon_not_found_error: STRING is
		indexing
			description: "Error message in case the dependency toolbar icon has not been found"
			external_name: "DependencyIconNotFoundError"
		once
			Result ?= Pixmap_not_found_error_part_1.clone
			Result := Result.concat_string_string_string (Result, Dependancy_viewer_icon_filename, Pixmap_not_found_error_part_2)
		ensure
			non_void_message: Result /= Void
			not_empty_message: Result.get_length > 0
		end

	Help_icon_not_found_error: STRING is
		indexing
			description: "Error message in case the help toolbar icon has not been found"
			external_name: "HelpIconNotFoundError"
		once
			Result ?= Pixmap_not_found_error_part_1.clone
			Result := Result.concat_string_string_string (Result, Help_icon_filename, Pixmap_not_found_error_part_2)
		ensure
			non_void_message: Result /= Void
			not_empty_message: Result.get_length > 0
		end
		
feature -- Other constants

	Data_table_title: STRING is "Assemblies table"
		indexing
			description: "Data table title"
			external_name: "DataTableTitle"
		end
	
	Dependancies_column_number: INTEGER is 4
		indexing
			description: "Dependancies column number"
			external_name: "DependanciesColumnNumber"
		end
				
	Empty_string: STRING is ""
		indexing
			description: "Empty string"
			external_name: "EmptyString"
		end		
		
	No_dependancy: STRING is "No dependency"
		indexing
			description: "No dependancy message"
			external_name: "NoDependancy"
		end

	Relative_help_filename: STRING is "\wizards\dotnet\assembly_manager.chm"
		indexing
			description: "Filename to `assembly_manager.chm' (relatively to Eiffel delivery path)"
			external_name: "RelativeHelpFilename"
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
		
	Title: STRING is "ISE Assembly Manager"
		indexing
			description: "Window title"
			external_name: "Title"
		end

	White_color: SYSTEM_DRAWING_COLOR is
		indexing
			description: "White color"
			external_name: "WhiteColor"
		once
			Result := Result.get_White
		end
		
	Window_height: INTEGER is 500
		indexing
			description: "Window height"
			external_name: "WindowHeight"
		end	

	Window_width: INTEGER is 750
			-- Window width
		indexing
			external_name: "WindowWidth"
		end

feature {NONE} -- Implementation
			
	Name_icon_relative_filename: STRING is "icon_assembly_name_color.ico"
		indexing
			description: "Filename of icon on name toolbar button"
			external_name: "NameIconRelativeFilename"			
		end
		
	Version_icon_relative_filename: STRING is "icon_assembly_version_color.ico"
		indexing
			description: "Filename of icon on version toolbar button"
			external_name: "VersionIconRelativeFilename"
		end

	Culture_icon_relative_filename: STRING is "icon_assembly_culture_color.ico"
		indexing
			description: "Filename of icon on culture toolbar button"
			external_name: "CultureIconRelativeFilename"
		end
		
	Public_key_icon_relative_filename: STRING is "icon_assembly_key_color.ico"
		indexing
			description: "Filename of icon on public key toolbar button"
			external_name: "PublicKeyIconRelativeFilename"
		end
		
	Dependancies_icon_relative_filename: STRING is "icon_assembly_dependencies_color.ico"
		indexing
			description: "Filename of icon on dependancies toolbar button"
			external_name: "DependanciesIconRelativeFilename"
		end

	Dependancy_viewer_icon_relative_filename: STRING is "icon_assembly_dependencies_dialog_color.ico"
		indexing
			description: "Filename of icon on dependancy viewer toolbar button"
			external_name: "DependancyViewerIconRelativeFilename"
		end
						
	Help_icon_relative_filename: STRING is "icon_assembly_help_color.ico"
		indexing
			description: "Filename of icon on help toolbar button"
			external_name: "HelpIconRelativeFilename"
		end
		
end -- class ASSEMBLY_VIEWER_DICTIONARY	
