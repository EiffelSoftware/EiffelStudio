indexing
	description: "Useful constants for imported assembly manager"
	external_name: "ISE.AssemblyManager.ImportedAssemblyViewerDictionary"

class
	IMPORTED_ASSEMBLY_VIEWER_DICTIONARY

inherit
	ASSEMBLY_VIEWER_DICTIONARY

feature -- Menu items

	Path_menu_item: STRING is "&Path to Eiffel sources"
		indexing
			description: "Text of eiffel path menu item"
			external_name: "PathMenuItem"
		end

	Show_name_and_path_menu_item: STRING is "&Show assembly name and path only"
		indexing
			description: "Text of show name and path menu item"
			external_name: "ShowNameAndPathMenuItem"
		end
		
	Edit_menu_item: STRING is "&Edit"
		indexing
			description: "Text of edit menu item"
			external_name: "EditMenuItem"
		end
		
	Remove_menu_item: STRING is "&Remove"
		indexing
			description: "Text of remove menu item"
			external_name: "RemoveMenuItem"
		end

	Eiffel_generation_menu_item: STRING is "Eiffel &Generation"
		indexing
			description: "Text of Eiffel menu item"
			external_name: "EiffelMenuItem"
		end
		
	Import_menu_item: STRING is "&Import Tool"
		indexing
			description: "Text of import tool menu item"
			external_name: "ImportToolMenuItem"
		end
						
feature -- Toolbar icons filename

	Path_icon_filename: STRING is
		indexing
			description: "Filename of icon on eiffel path toolbar button"
			external_name: "PathIconFilename"
		once
			Result := base_filename
			Result := Result.concat_string_string (Result, Path_icon_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: Result.get_length > 0
		end
		
	Edit_icon_filename: STRING is 
		indexing
			description: "Filename of icon on edit toolbar button"
			external_name: "EditIconFilename"
		once
			Result := base_filename
			Result := Result.concat_string_string (Result, Edit_icon_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: Result.get_length > 0
		end
		
	Remove_icon_filename: STRING is 
		indexing
			description: "Filename of icon on remove toolbar button"
			external_name: "RemoveIconFilename"
		once
			Result := base_filename
			Result := Result.concat_string_string (Result, Remove_icon_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: Result.get_length > 0
		end
		
	Eiffel_generation_icon_filename: STRING is 
		indexing
			description: "Filename of icon on Eiffel generation toolbar button"
			external_name: "EiffelGenerationIconFilename"
		once
			Result := base_filename
			Result := Result.concat_string_string (Result, Eiffel_generation_icon_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: Result.get_length > 0
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
			not_empty_filename: Result.get_length > 0
		end

feature -- Column Names

	Eiffel_path_column_title: STRING is "Path to Eiffel sources"
		indexing
			description: "Eiffel path column title"
			external_name: "EiffelPathColumnTitle"
		end

feature -- Messages

	Edit_assembly_message: STRING is "Editing assembly..." 
		indexing
			description: "Message to the user before displaying the type view."
			external_name: "EditAssemblyMessage"
		end

	Path_icon_not_found_error: STRING is
		indexing
			description: "Error message in case the path toolbar icon has not been found"
			external_name: "PathIconNotFoundError"
		once
			Result ?= Pixmap_not_found_error_part_1.clone
			Result := Result.concat_string_string_string (Result, Path_icon_filename, Pixmap_not_found_error_part_2)
		ensure
			non_void_message: Result /= Void
			not_empty_message: Result.get_length > 0
		end
		
	Edit_icon_not_found_error: STRING is
		indexing
			description: "Error message in case the edit toolbar icon has not been found"
			external_name: "EditIconNotFoundError"
		once
			Result ?= Pixmap_not_found_error_part_1.clone
			Result := Result.concat_string_string_string (Result, Edit_icon_filename, Pixmap_not_found_error_part_2)
		ensure
			non_void_message: Result /= Void
			not_empty_message: Result.get_length > 0
		end
		
	Remove_icon_not_found_error: STRING is
		indexing
			description: "Error message in case the remove toolbar icon has not been found"
			external_name: "RemoveIconNotFoundError"
		once
			Result ?= Pixmap_not_found_error_part_1.clone
			Result := Result.concat_string_string_string (Result, Remove_icon_filename, Pixmap_not_found_error_part_2)
		ensure
			non_void_message: Result /= Void
			not_empty_message: Result.get_length > 0
		end
		
	Eiffel_generation_icon_not_found_error: STRING is
		indexing
			description: "Error message in case the Eiffel generation toolbar icon has not been found"
			external_name: "EiffelGenerationIconNotFoundError"
		once
			Result ?= Pixmap_not_found_error_part_1.clone
			Result := Result.concat_string_string_string (Result, Eiffel_generation_icon_filename, Pixmap_not_found_error_part_2)
		ensure
			non_void_message: Result /= Void
			not_empty_message: Result.get_length > 0
		end
		
	Import_icon_not_found_error: STRING is
		indexing
			description: "Error message in case the Import toolbar icon has not been found"
			external_name: "ImportIconNotFoundError"
		once
			Result ?= Pixmap_not_found_error_part_1.clone
			Result := Result.concat_string_string_string (Result, Import_icon_filename, Pixmap_not_found_error_part_2)
		ensure
			non_void_message: Result /= Void
			not_empty_message: Result.get_length > 0
		end
		
feature -- Other constants
	
	Caption_text: STRING is "Imported Assemblies"
		indexing
			description: "Text that appears in the blue header of the data grid"
			external_name: "CaptionText"
		end

	Non_editable_assembly: STRING is "This assembly cannot be edited."
		indexing
			description: "Error message in case the user wants to edit an assembly that cannot be edited"
			external_name: "NonEditbleAssembly"
		end

	Mscorlib_assembly_name: STRING is "mscorlib"
		indexing
			description: "Name of `mscorlib.dll'"
			external_name: "MscorlibAssemblyName"
		end
		
feature {NONE} -- Implementation

	Path_icon_relative_filename: STRING is "icon_assembly_paths_color.ico"
		indexing
			description: "Filename of icon on eiffel path toolbar button"
			external_name: "PathIconRelativeFilename"
		end
		
	Edit_icon_relative_filename: STRING is "icon_edit_assembly_color.ico"
		indexing
			description: "Filename of icon on edit toolbar button"
			external_name: "EditIconRelativeFilename"
		end
		
	Remove_icon_relative_filename: STRING is "icon_delete_color.ico"
		indexing
			description: "Filename of icon on remove toolbar button"
			external_name: "RemoveIconRelativeFilename"
		end
		
	Eiffel_generation_icon_relative_filename: STRING is "icon_to_eiffel_color.ico"
		indexing
			description: "Filename of icon on Eiffel generation toolbar button"
			external_name: "EiffelGenerationIconRelativeFilename"
		end

	Import_icon_relative_filename: STRING is "icon_import_assembly_tool_color.ico"
		indexing
			description: "Filename of icon on import toolbar button"
			external_name: "ImportIconRelativeFilename"
		end
		
end -- class IMPORTED_ASSEMBLY_VIEWER_DICTIONARY	
