indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.GenerationDialogDictionary"

class
	GENERATION_DIALOG_DICTIONARY

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

	Cancel: INTEGER is 2
		indexing
			description: "Value indicating that the `Cancel' button of the message box has been clicked"
			external_name: "Cancel"
		end
		
	Cancel_button_label: STRING is "Cancel"
			-- Cancel button label
		indexing
			external_name: "CancelButtonLabel"
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

	No_path: STRING is "Please select a folder where Eiffel code will be generated."
		indexing
			description: "Error message when no path has been selected"
			external_name: "NoPath"
		end
		
	Ok_button_label: STRING is "OK"
			-- OK button label
		indexing
			external_name: "OkButtonLabel"
		end
	
	Path_key: STRING is "Eiffel_path"
		indexing
			description: "Environment variable used to retrieve lastly selected path"
			external_name: "PathKey"
		end
		
	Window_width: INTEGER is 500
			-- Window width
		indexing
			external_name: "WindowWidth"
		end
		
end -- class GENERATION_DIALOG_DICTIONARY
