indexing
	description: "Useful constants for assembly manager"
	external_name: "AssemblyManager.WarningDialogDictionary"

class
	WARNING_DIALOG_DICTIONARY

inherit
	DIALOG_DICTIONARY
	
feature -- Access

	Assembly_label_text: STRING is "Selected assembly: "
			-- Text of assembly label
		indexing
			external_name: "AssemblyLabelText"
		end
	
	Dependancies_label_text: STRING is "Dependancies: "
			-- Text of dependancies label
		indexing
			external_name: "DependanciesLabelText"
		end

	No_button_label: STRING is "No"
			-- No button label
		indexing
			external_name: "NoButtonLabel"
		end
		
	Title: STRING is "WARNING - Assembly manager"
			-- Window title
		indexing
			external_name: "Title"
		end
		
	Yes_button_label: STRING is "Yes"
			-- Yes button label
		indexing
			external_name: "YesButtonLabel"
		end

end -- class WARNING_DIALOG_DICTIONARY
