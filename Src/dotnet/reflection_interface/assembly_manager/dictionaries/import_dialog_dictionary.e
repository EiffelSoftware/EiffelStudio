indexing
	description: "Useful constants for assembly manager"
	external_name: "AssemblyManager.ImportDialogDictionary"

class
	IMPORT_DIALOG_DICTIONARY

inherit
	DIALOG_DICTIONARY
	
feature -- Access
		
	Assembly_label_text: STRING is "Selected assembly: "
			-- Text of assembly label
		indexing
			external_name: "AssemblyLabelText"
		end

	Browse_button_label: STRING is "Browse..."
			-- Browse button label
		indexing
			external_name: "BrowseButtonLabel"
		end

	Cancel_button_label: STRING is "Cancel"
			-- Cancel button label
		indexing
			external_name: "CancelButtonLabel"
		end
		
	Dependancies_check_box_text: STRING is "Import assembly dependancies"
			-- Dependancies check box text
		indexing
			external_name: "DependanciesCheckBoxText"
		end
		
	Destination_path_label_text: STRING is "Destination path: " 
			-- Text of destination path label
		indexing
			external_name: "DestinationPathLabelText"
		end

	Destination_path_selection_title: STRING is "Select a destination path"
			-- Title of browse dialog used to select the destination path
		indexing
			external_name: "DestinationPathSelectionTitle"
		end
		
	Empty_string: STRING is ""
			-- Empty string
		indexing
			external_name: "EmptyString"
		end
		
	Explanation_label_text: STRING is "Path to directory where Eiffel classes will be generated." 
			-- Explanation of destination path
		indexing
			external_name: "ExplanationLabelText"
		end	
	
	Neutral_culture: STRING is "neutral"
			-- Neutral culture
		indexing
			external_name: "NeutralCulture"
		end
		
	Ok_button_label: STRING is "OK"
			-- OK button label
		indexing
			external_name: "OkButtonLabel"
		end

	Title: STRING is "Import a .NET assembly"
			-- Window title
		indexing
			external_name: "Title"
		end
	
	Warning_text: STRING is "Are you sure you want to import the .NET assembly without its dependancies?"
			-- Warning in case user does not ask for importation of assembly dependancies
		indexing
			external_name: "WarningText"
		end

end -- class IMPORT_DIALOG_DICTIONARY
