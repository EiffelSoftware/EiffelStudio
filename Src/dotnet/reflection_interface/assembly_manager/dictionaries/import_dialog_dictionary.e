indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.ImportDialogDictionary"

class
	IMPORT_DIALOG_DICTIONARY

inherit
	DIALOG_DICTIONARY
	
feature -- Access
	
	Assembly_and_dependancies_importation_message: STRING is "The assembly manager will now import the selected assembly and its dependancies. This may take a few minutes. Please be patient."
			-- Message to let the user know selected assembly and its dependancies will be imported to the Eiffel repository.
		indexing
			external_name: "AssemblyAndDependanciesImportationMessage"
		end

	Assembly_importation_message: STRING is "The assembly manager will now import the selected assembly without any dependancies. This may take a few minutes. Please be patient."
			-- Message to let the user know selected assembly will be imported to the Eiffel repository.
		indexing
			external_name: "AssemblyImportationMessage"
		end
		
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

	Red_color: SYSTEM_DRAWING_COLOR
			-- Red color
		indexing
			external_name: "RedColor"
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
