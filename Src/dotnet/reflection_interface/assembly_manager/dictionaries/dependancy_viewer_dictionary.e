indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.DependancyViewerDictionary"

class
	DEPENDANCY_VIEWER_DICTIONARY

inherit
	DEPENDANCY_DIALOG_DICTIONARY

feature -- Access

	Assembly_label_text: STRING is "Selected assembly: "
			-- Text of assembly label
		indexing
			external_name: "AssemblyLabelText"
		end

	Caption_text: STRING is "Dependencies"
		indexing
			description: "Text that appears in the blue header of the data grid"
			external_name: "CaptionText"
		end
		
	Dependancies_icon: SYSTEM_DRAWING_ICON is
		indexing
			description: "Icon appearing in dependancy viewer header"
			external_name: "DependanciesIcon"
		once
			create Result.make_icon (Dependancies_icon_filename)
		ensure
			icon_created: Result /= Void
		end

	Dependancies_icon_filename: STRING is "F:\Src\dotnet\reflection_interface\assembly_manager\icons\icon_title_dependencies_color.ico"
		indexing
			description: "Filename of icon appearing in dependancy viewer header"
			external_name: "DependanciesIconFilename"
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