indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.WarningDialogDictionary"

class
	WARNING_DIALOG_DICTIONARY

inherit
	DEPENDANCY_DIALOG_DICTIONARY
	
feature -- Access

	Assembly_label_text: STRING is "Selected assembly: "
		indexing
			description: "Text of assembly label"
			external_name: "AssemblyLabelText"
		end
		
	No_button_label: STRING is "No"
		indexing
			description: "No button label"
			external_name: "NoButtonLabel"
		end
			
	Title: STRING is "WARNING - ISE Assembly Manager"
		indexing
			description: "Window title"
			external_name: "Title"
		end

	Yes_button_label: STRING is "Yes"
		indexing
			description: "Yes button label"
			external_name: "YesButtonLabel"
		end
		
end -- class WARNING_DIALOG_DICTIONARY
