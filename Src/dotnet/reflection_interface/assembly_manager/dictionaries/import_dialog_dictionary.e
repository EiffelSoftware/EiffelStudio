indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.ImportDialogDictionary"

class
	IMPORT_DIALOG_DICTIONARY

inherit
	GENERATION_DIALOG_DICTIONARY
	
feature -- Access
	
	Assembly_and_dependancies_importation_message: STRING is "Importing assembly and dependencies..."
		indexing
			description: "Message to let the user know selected assembly and its dependancies will be imported to the Eiffel repository."
			external_name: "AssemblyAndDependanciesImportationMessage"
		end

	Assembly_importation_message: STRING is "Importing assembly..."
		indexing
			description: "Message to let the user know selected assembly will be imported to the Eiffel repository"
			external_name: "AssemblyImportationMessage"
		end
		
	Caption_text: STRING is "Non imported dependencies"
		indexing
			description: "Text that appears in the blue header of the data grid"
			external_name: "CaptionText"
		end

	Default_generation_path: STRING is
		indexing
			description: "Default generation path"
			external_name: "DefaultGenerationPath"
		local
			reflection_support: ISE_REFLECTION_REFLECTIONSUPPORT
		once
			create reflection_support.make_reflectionsupport
			reflection_support.make
			Result := reflection_support.Eiffeldeliverypath
			Result := Result.Concat_string_string (Result, Dotnet_library_relative_path)
		ensure
			non_void_path: Result /= Void
			not_empty_path: Result.length > 0
		end
		
	Dependancies_check_box_text: STRING is "Import assembly dependencies"
		indexing
			description: "Dependancies check box text"
			external_name: "DependanciesCheckBoxText"
		end
	
	Eiffel_names_check_box_text: STRING is "Generate Eiffel-friendly names"
		indexing
			description: "Text of `eiffel_names_check_box'"
			external_name: "EiffelNamesCheckBoxText"
		end
		
	Importation_error: STRING is "An errors occurred during assembly importation. Please check the assembly is signed. If not, sign it and try importation again."
		indexing
			description: "Error message when assembly importation fails"
			external_name: "ImportationError"
		end

	Import_icon: SYSTEM_DRAWING_ICON is
		indexing
			description: "Icon appearing in import dialog header"
			external_name: "ImportIcon"
		once
			create Result.make_icon (Import_icon_filename)
		ensure
			icon_created: Result /= Void
		end

	Import_icon_filename: STRING is 
		indexing
			description: "Filename of icon appearing in import tool header"
			external_name: "ImportIconFilename"
		once
			Result := Base_filename
			Result := Result.concat_string_string (Result, Import_icon_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: Result.length > 0
		end
				
	Title: STRING is "Import a .NET assembly"
		indexing
			description: "Window title"
			external_name: "Title"
		end
	
	Warning_text: STRING is "Are you sure you want to import the .NET assembly without its dependencies?"
		indexing
			description: "Warning in case user does not ask for importation of assembly dependancies"
			external_name: "WarningText"
		end

	Window_height: INTEGER is 330
		indexing
			description: "Window height"
			external_name: "WindowHeight"
		end

feature {NONE} -- Implementation

	Import_icon_relative_filename: STRING is "\icon_import_assembly_title_color.ico"
		indexing
			description: "Filename of icon appearing in import dialog header"
			external_name: "ImportIconRelativeFilename"
		end

end -- class IMPORT_DIALOG_DICTIONARY
