indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.RemoveDialogDictionary"

class
	REMOVE_DIALOG_DICTIONARY

inherit
	DIALOG_DICTIONARY
	
feature -- Access
	
	Assembly_label_text: STRING is "Selected assembly: "
			-- Text of assembly label
		indexing
			external_name: "AssemblyLabelText"
		end

	Caption_text: STRING is "Removable Dependencies"
		indexing
			description: "Text that appears in the blue header of the data grid"
			external_name: "CaptionText"
		end
		
	Dependancies_check_box_text: STRING is "Remove dependencies."
			-- Check box for dependancies removal
		indexing
			external_name: "DependanciesCheckBoxText"
		end
		
	No_button_label: STRING is "No"
			-- No button label
		indexing
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
			-- Question to the user
		indexing
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

	Remove_icon_filename: STRING is "F:\Src\dotnet\reflection_interface\assembly_manager\icons\icon_delete_color.ico"
		indexing
			description: "Filename of icon appearing in remove dialog header"
			external_name: "RemoveIconFilename"
		end
		
	Title: STRING is "Remove a .NET assembly"
			-- Window title
		indexing
			external_name: "Title"
		end
		
	Warning_text: STRING is "Are you sure you want to remove the assembly and its dependencies?"
			-- Warning in case user asks for removal of assembly dependancies
		indexing
			external_name: "WarningText"
		end

	Window_height: INTEGER is 220
			-- Window height
		indexing
			external_name: "WindowHeight"
		end
		
	Window_width: INTEGER is 500
			-- Window width
		indexing
			external_name: "WindowWidth"
		end
		
	Yes_button_label: STRING is "Yes"
			-- Yes button label
		indexing
			external_name: "YesButtonLabel"
		end

end -- class REMOVE_DIALOG_DICTIONARY
