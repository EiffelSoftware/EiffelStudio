indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.WarningDialogDictionary"

class
	WARNING_DIALOG_DICTIONARY

inherit
	DEPENDANCY_DIALOG_DICTIONARY
	
feature -- Access

	Assembly_label_text: STRING is "Selected assembly: "
			-- Text of assembly label
		indexing
			external_name: "AssemblyLabelText"
		end
		
	No_button_label: STRING is "No"
			-- No button label
		indexing
			external_name: "NoButtonLabel"
		end
		
	Title: STRING is "WARNING - ISE Assembly Manager"
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
