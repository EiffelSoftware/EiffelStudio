indexing
	description: "Useful constants for assembly manager"
	external_name: "AssemblyManager.DependancyViewerDictionary"

class
	DEPENDANCY_VIEWER_DICTIONARY

inherit
	DIALOG_DICTIONARY

feature -- Access

	Assembly_label_text: STRING is "Selected assembly: "
			-- Text of assembly label
		indexing
			external_name: "AssemblyLabelText"
		end

	Close_button_label: STRING is "Close"
			-- Close button label
		indexing
			external_name: "CloseButtonLabel"
		end
	
	Dependancies_label_text: STRING is "Dependancies: " 
			-- Text of dependancies label
		indexing
			external_name: "DependanciesLabelText"
		end

	No_dependancies_text: STRING is "The selected assembly has no dependancy."
			-- Text whenever selected assembly has no dependancy	
		indexing
			external_name: "NoDependanciesText"
		end
		
	Title: STRING is "Dependancy viewer"
			-- Window title
		indexing
			external_name: "Title"
		end
		
end -- class DEPENDANCY_VIEWER_DICTIONARY