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

	Dependancies_check_box_text: STRING is "Remove dependancies."
			-- Check box for dependancies removal
		indexing
			external_name: "DependanciesCheckBoxText"
		end

	No_button_label: STRING is "No"
			-- No button label
		indexing
			external_name: "NoButtonLabel"
		end
		
	Question_label_text: STRING is "Are you sure you want to remove the selected .NET assembly?"
			-- Question to the user
		indexing
			external_name: "QuestionLabelText"
		end

	Title: STRING is "Remove a .NET assembly"
			-- Window title
		indexing
			external_name: "Title"
		end
		
	Warning_text: STRING is "Are you sure you want to remove the assembly and its dependancies?"
			-- Warning in case user asks for removal of assembly dependancies
		indexing
			external_name: "WarningText"
		end
		
	Yes_button_label: STRING is "Yes"
			-- Yes button label
		indexing
			external_name: "YesButtonLabel"
		end

end -- class REMOVE_DIALOG_DICTIONARY
