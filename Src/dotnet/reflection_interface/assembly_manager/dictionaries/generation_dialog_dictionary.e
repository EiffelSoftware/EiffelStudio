indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.GenerationDialogDictionary"

class
	GENERATION_DIALOG_DICTIONARY

inherit
	DIALOG_DICTIONARY
	
feature -- Access
		
	Assembly_label_text: STRING is "Selected assembly: "
		indexing
			description: "Text of assembly label"
			external_name: "AssemblyLabelText"
		end

	Browse_button_label: STRING is "Browse..."
		indexing
			description: "Browse button label"
			external_name: "BrowseButtonLabel"
		end
		
	Cancel_button_label: STRING is "Cancel"
		indexing
			description: "Cancel button label"
			external_name: "CancelButtonLabel"
		end

	Default_path_check_box_text: STRING is "Default path"
		indexing
			description: "Text of `default_path_check_box'"
			external_name: "DefaultPathCheckBoxText"
		end
		
	Destination_path_label_text: STRING is "Destination path: " 
		indexing
			description: "Text of destination path label"
			external_name: "DestinationPathLabelText"
		end

	Destination_path_selection_title: STRING is "Select a destination path"
		indexing
			description: "Title of browse dialog used to select the destination path"
			external_name: "DestinationPathSelectionTitle"
		end
		
	Empty_string: STRING is ""
		indexing
			description: "Empty string"
			external_name: "EmptyString"
		end
		
	Explanation_label_text: STRING is "Path to directory where Eiffel classes will be generated." 
		indexing
			description: "Explanation of destination path"
			external_name: "ExplanationLabelText"
		end	

	Explanation_text: STRING is "(A new folder named as the assembly will automatically be created)"
		indexing
			description: "Explanation text"
			external_name: "ExplanationText"
		end
			
	Neutral_culture: STRING is "neutral"
		indexing
			description: "Neutral culture"
			external_name: "NeutralCulture"
		end

	No_path: STRING is "Please select a folder where Eiffel code will be generated."
		indexing
			description: "Error message when no path has been selected"
			external_name: "NoPath"
		end
		
	Ok_button_label: STRING is "OK"
		indexing
			description: "OK button label"
			external_name: "OkButtonLabel"
		end
	
	Path_key: STRING is "Eiffel_path"
		indexing
			description: "Environment variable used to retrieve lastly selected path"
			external_name: "PathKey"
		end
		
	Window_width: INTEGER is 500
		indexing
			description: "Window width"
			external_name: "WindowWidth"
		end

feature {NONE} -- Implementation

	Dotnet_library_relative_path: STRING is "\library.net"
		indexing
			description: "Path to `library.net' relatively to Eiffel delivery"
			external_name: "DotnetLibraryRelativePath"
		end
		
end -- class GENERATION_DIALOG_DICTIONARY
