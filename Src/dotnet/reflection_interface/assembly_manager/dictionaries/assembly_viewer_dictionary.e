indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.AssemblyViewerDictionary"

class
	ASSEMBLY_VIEWER_DICTIONARY

inherit
	DICTIONARY

feature -- Access

	All_assemblies_button_label: STRING is "All assemblies"
			-- All assemblies button label
		indexing
			external_name: "AllAssembliesButtonLabel"
		end

	Assembly_culture_column_title: STRING is "Culture"
			-- Assembly culture column title
		indexing
			external_name: "AssemblyCultureColumnTitle"
		end

	Assembly_importation_handler_type: STRING is "AssemblyManager.AssemblyImportationHandler"
			-- `AssemblyManager.AssemblyImportationHandler' type as a string
		indexing
			external_name: "AssemblyImportationHandlerType"
		end
		
	Assembly_manager_title: STRING is "Assembly Manager"
			-- Window title
		indexing
			external_name: "AssemblyManagerTitle"
		end
		
	Assembly_name_column_title: STRING is "Name"
			-- Assembly name column title
		indexing
			external_name: "AssemblyNameColumnTitle"
		end
		
	Assembly_public_key_column_title: STRING is "Public Key"
			-- Assembly public key column title
		indexing
			external_name: "AssemblyPublicKeyColumnTitle"
		end

	Assembly_removal_handler_type: STRING is "AssemblyManager.AssemblyRemovalHandler"
			-- `AssemblyManager.AssemblyRemovalHandler' type as a string
		indexing
			external_name: "AssemblyRemovalHandlerType"
		end
		
	Assembly_version_column_title: STRING is "Version"
			-- Assembly version column title
		indexing
			external_name: "AssemblyVersionColumnTitle"
		end
	
--	Button_appearance: INTEGER is 1
--			-- Appearance enum value for Button.
--		indexing
--			exernal_name: "ButtonAppearance"
--		end
		
	Data_table_title: STRING is "Assembly viewer table"
			-- Data table title
		indexing
			external_name: "DataTableTitle"
		end
	
	Dependancies_column_title: STRING is "Dependancies"
			-- Dependancies column title
		indexing
			external_name: "DependanciesColumnTitle"
		end	

	Edit_button_label: STRING is "Edit"
			-- Edit button label
		indexing
			external_name: "EditButtonLabel"
		end
		
	Eiffel_path_column_title: STRING is "Path to Eiffel sources"
			-- Eiffel path column title
		indexing
			external_name: "EiffelPathColumnTitle"
		end
		
	Empty_string: STRING is ""
			-- Empty string
		indexing
			external_name: "EmptyString"
		end		

	Error_message: STRING is "An internal error has occurred."
			-- Error message
		indexing
			external_name: "ErrorMessage"
		end
		
	Hide_dependancies_button_label: STRING is "Hide dependancies"
			-- Hide dependancies button label
		indexing
			external_name: "HideDependanciesButtonLabel"
		end

	Import_button_label: STRING is "Import"
			-- Import button label
		indexing
			external_name: "ImportButtonLabel"
		end
	
	Imported_assemblies_button_label: STRING is "Imported assemblies"
			-- Imported assemblies button label
		indexing
			external_name: "ImportedAssembliesButtonLabel"
		end		

	Invitation_message: STRING is "Please start assembly manager again."
			-- Invitation message after error message
		indexing
			external_name: "InvitationMessage"
		end
		
--	Large_button_width: INTEGER is 150
--			-- Width of large buttons
--		indexing
--			external_name: "LargeButtonWidth"
--		end
		
--	Middle_center_alignment: INTEGER is 32
--			-- ContentAlignment enum value for MiddleCenter.
--		indexing
--			external_name: "MiddleCenterAlignment"
--		end
		
	No_dependancy: STRING is "No dependancy"
			-- No dependancy message
		indexing
			external_name: "NoDependancy"
		end

	Not_imported_yet: STRING is "Not imported yet"
			-- Message telling the user assembly has not been imported yet
		indexing
			external_name: "NotImportedYet"
		end

	Red_color: SYSTEM_DRAWING_COLOR is
			-- Red color
		indexing
			external_name: "RedColor"
		once
			Result := Result.Red
		end
		
	Remove_button_label: STRING is "Remove"
			-- Remove button label
		indexing
			external_name: "RemoveButtonLabel"
		end

	Show_dependancies_button_label: STRING is "Show dependancies"
			-- Hide dependancies button label
		indexing
			external_name: "ShowDependanciesButtonLabel"
		end
		
	System_string_type: STRING is "System.String"
			-- System.String type
		indexing
			external_name: "SystemStringType"
		end

	System_windows_forms_assembly_path: STRING is "C:\WINNT\Microsoft.NET\Framework\v1.0.2728\SYSTEM.WINDOWS.FORMS.DLL"
			-- Path to `System.Windows.Forms.dll'
		indexing
			external_name: "SystemWindowsFormsAssemblyPath"
		end
		
	System_windows_forms_mouse_event_handler_type: STRING is "System.Windows.Forms.MouseEventHandler"
			-- System.Windows.Forms.MouseEventHandler type
		indexing
			external_name: "SystemWindowsFormsMouseEventHandlerType"
		end

--	Table_height: INTEGER is 480
--			-- Table height
--		indexing
--			external_name: "TableHeight"
--		end
		
	Title: STRING is "Assembly viewer"
			-- Window title
		indexing
			external_name: "Title"
		end

	White_color: SYSTEM_DRAWING_COLOR is
			-- White color
		indexing
			external_name: "WhiteColor"
		once
			Result := Result.White
		end
		
--	Window_height: INTEGER is 600
--			-- Window height
--		indexing
--			external_name: "WindowHeight"
--		end	

end -- class ASSEMBLY_VIEWER_DICTIONARY	
