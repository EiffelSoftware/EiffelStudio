indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.DependancyViewerDictionary"

class
	DEPENDANCY_VIEWER_DICTIONARY

inherit
	DEPENDANCY_DIALOG_DICTIONARY

feature -- Access

	Assembly_label_text: STRING is "Selected assembly: "
		indexing
			description: "Text of assembly label"
			external_name: "AssemblyLabelText"
		end

	Caption_text: STRING is "Dependencies"
		indexing
			description: "Text that appears in the blue header of the data grid"
			external_name: "CaptionText"
		end
		
	Dependancies_icon: DRAWING_ICON is
		indexing
			description: "Icon appearing in dependancy viewer header"
			external_name: "DependanciesIcon"
		once
			create Result.make_drawing_icon (Dependancies_icon_filename.to_cil)
		ensure
			icon_created: Result /= Void
		end

	Dependancies_icon_filename: STRING is 
		indexing
			description: "Filename of icon appearing in dependancy viewer header"
			external_name: "DependanciesIconFilename"
		once
			Result := Base_filename.clone (Base_filename)
			Result.append (Dependancies_icon_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: Result.count > 0
		end
		
	No_dependancies_text: STRING is "The selected assembly has no dependency."
		indexing
			description: "Text whenever selected assembly has no dependancy"
			external_name: "NoDependanciesText"
		end
		
	Title: STRING is "Dependency viewer"
		indexing
			description: "Window title"
			external_name: "Title"
		end

feature {NONE} -- Implementation

	Dependancies_icon_relative_filename: STRING is "\icon_title_dependencies_color.ico"
		indexing
			description: "Filename of icon appearing in dependancy viewer header"
			external_name: "DependanciesIconRelativeFilename"
		end

end -- class DEPENDANCY_VIEWER_DICTIONARY