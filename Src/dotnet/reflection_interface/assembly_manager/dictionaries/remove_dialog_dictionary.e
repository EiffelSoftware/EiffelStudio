indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.RemoveDialogDictionary"

class
	REMOVE_DIALOG_DICTIONARY

inherit
	DIALOG_DICTIONARY
	
feature -- Access
	
	Assembly_label_text: STRING is "Selected assembly: "
		indexing
			description: "Text of assembly label"
			external_name: "AssemblyLabelText"
		end

	Caption_text: STRING is "Removable Dependencies"
		indexing
			description: "Text that appears in the blue header of the data grid"
			external_name: "CaptionText"
		end
		
	Dependancies_check_box_text: STRING is "Remove dependencies."
		indexing
			description: "Check box for dependancies removal"
			external_name: "DependanciesCheckBoxText"
		end

	Mscorlib_assembly_name: STRING is "mscorlib"
		indexing
			description: "Name of `mscorlib.dll'"
			external_name: "MscorlibAssemblyName"
		end
		
	No_button_label: STRING is "No"
		indexing
			description: "No button label"
			external_name: "NoButtonLabel"
		end
	
	Non_removable_assembly: STRING is "This assembly cannot be removed from the Eiffel Assembly Cache."
		indexing
			description: "Error message in case the user asks for removal of an assembly that cannot be removed from the Eiffel assembly cache"
			external_name: "NonRemovableAssembly"
		end
	
	Non_removable_dependancies: STRING is "The dependencies of the selected assembly cannot be removed from the Eiffel Assembly Cache. Thus only the selected assembly will be removed."
		indexing
			description: "Information message in case the user asks for removal of assembly dependancies and these cannot be removed from the Eiffel assembly cache"
			external_name: "NonRemovableDependancies"
		end
	
	Question_label_text: STRING is "Are you sure you want to remove the selected .NET assembly?"
		indexing
			description: "Question to the user"
			external_name: "QuestionLabelText"
		end

	Remove_icon: SYSTEM_DRAWING_ICON is
		indexing
			description: "Icon appearing in remove dialog header"
			external_name: "RemoveIcon"
		once
			create Result.make_icon (Remove_icon_filename)
		ensure
			icon_created: Result /= Void
		end

	Remove_icon_filename: STRING is 
		indexing
			description: "Filename of icon appearing in remove dialog header"
			external_name: "RemoveIconFilename"
		once
			Result := Base_filename
			Result := Result.concat_string_string (Result, Remove_icon_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: Result.get_length > 0
		end

	System_assembly_name: STRING is "system"
		indexing
			description: "Name of `System.dll'"
			external_name: "SystemAssemblyName"
		end
		
	Title: STRING is "Remove a .NET assembly"
		indexing
			description: "Window title"
			external_name: "Title"
		end
		
	Warning_text: STRING is "Are you sure you want to remove the assembly and its dependencies?"
		indexing
			description: "Warning in case user asks for removal of assembly dependancies"
			external_name: "WarningText"
		end

	Window_height: INTEGER is 190
		indexing
			description: "Window height"
			external_name: "WindowHeight"
		end
		
	Window_width: INTEGER is 500
		indexing
			description: "Window width"
			external_name: "WindowWidth"
		end
		
	Yes_button_label: STRING is "Yes"
		indexing
			description: "Yes button label"
			external_name: "YesButtonLabel"
		end

feature {NONE} -- Implementation

	Remove_icon_relative_filename: STRING is "\icon_delete_color.ico"
		indexing
			description: "Filename of icon appearing in remove dialog header"
			external_name: "RemoveIconRelativeFilename"
		end

end -- class REMOVE_DIALOG_DICTIONARY
