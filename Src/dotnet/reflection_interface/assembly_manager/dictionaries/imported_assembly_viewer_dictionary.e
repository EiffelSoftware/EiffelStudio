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
		
	Import_menu_item: STRING is "&Import Tool"
		indexing
			description: "Text of import tool menu item"
			external_name: "ImportToolMenuItem"
		end
				
feature -- Shortcuts

	Ctrl_P_shortcut: INTEGER is 131152
		indexing
			description: "Ctrl+P shortcut, enum value: 0x 20050"
			external_name: "CtrlPShortcut"
		end
		
	Ctrl_E_shortcut: INTEGER is 131141
		indexing
			description: "Ctrl+E shortcut, enum value: 0x 20045"
			external_name: "CtrlEShortcut"
		end

	Ctrl_R_shortcut: INTEGER is 131154
		indexing
			description: "Ctrl+R shortcut, enum value: 0x 20052"
			external_name: "CtrlRShortcut"
		end

feature -- Toolbar icons filename

	Path_icon_filename: STRING is "F:\Eiffel50\bench\bitmaps\bmp\general.bmp"
		indexing
			description: "Filename of icon on eiffel path toolbar button"
			external_name: "PathIconFilename"
		end

	Show_name_and_path_icon_filename: STRING is "F:\Eiffel50\bench\bitmaps\bmp\general.bmp"	
		indexing
			description: "Filename of icon on `show name and path' toolbar button"
			external_name: "ShowNameAndPathIconFilename"
		end
		
	Edit_icon_filename: STRING is "F:\Eiffel50\bench\bitmaps\bmp\editobj.bmp"
		indexing
			description: "Filename of icon on edit toolbar button"
			external_name: "EditIconFilename"
		end
		
	Remove_icon_filename: STRING is "F:\Eiffel50\bench\bitmaps\bmp\smodifie.bmp"
		indexing
			description: "Filename of icon on remove toolbar button"
			external_name: "RemoveIconFilename"
		end
		
	Import_icon_filename: STRING is "F:\Eiffel50\bench\bitmaps\bmp\update.bmp"
		indexing
			description: "Filename of icon on import toolbar button"
			external_name: "ImportIconFilename"
		end

feature -- Column Names

	Eiffel_path_column_title: STRING is "Path to Eiffel sources"
		indexing
			description: "Eiffel path column title"
			external_name: "EiffelPathColumnTitle"
		end

feature -- Messages

	Edit_type_message: STRING is "ISE Assembly Manager will now retrieve assembly types. This may take a few seconds. Please be patient." 
		indexing
			description: "Message to the user before displaying the type view."
			external_name: "EditTypeMessage"
		end

feature -- Other constants

	Caption_text: STRING is "Imported Assemblies"
		indexing
			description: "Text that appears in the blue header of the data grid"
			external_name: "CaptionText"
		end
		
end -- class IMPORTED_ASSEMBLY_VIEWER_DICTIONARY	
