indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.ImportDialogDictionary"

class
	IMPORT_DIALOG_DICTIONARY

inherit
	GENERATION_DIALOG_DICTIONARY
	
feature -- Access
	
	Assembly_and_dependancies_importation_message: STRING is "The assembly manager will now import the selected assembly and its dependencies. This may take a few minutes. Please be patient."
			-- Message to let the user know selected assembly and its dependancies will be imported to the Eiffel repository.
		indexing
			external_name: "AssemblyAndDependanciesImportationMessage"
		end

	Assembly_importation_message: STRING is "The assembly manager will now import the selected assembly without any dependencies. This may take a few minutes. Please be patient."
			-- Message to let the user know selected assembly will be imported to the Eiffel repository.
		indexing
			external_name: "AssemblyImportationMessage"
		end
		
	Caption_text: STRING is "Non imported dependencies"
		indexing
			description: "Text that appears in the blue header of the data grid"
			external_name: "CaptionText"
		end
		
	Dependancies_check_box_text: STRING is "Import assembly dependencies"
			-- Dependancies check box text
		indexing
			external_name: "DependanciesCheckBoxText"
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

	Importation_error: STRING is "An errors occurred during assembly importation. Please check the assembly is signed. If not, sign it and try importation again."
		indexing
			description: "Error message when assembly importation fails"
			external_name: "ImportationError"
		end

	Import_icon_filename: STRING is "F:\Src\dotnet\reflection_interface\assembly_manager\icons\icon_import_assembly_title_color.ico"
		indexing
			description: "Filename of icon appearing in import dialog header"
			external_name: "ImportIconFilename"
		end
		
	Title: STRING is "Import a .NET assembly"
			-- Window title
		indexing
			external_name: "Title"
		end
	
	Warning_text: STRING is "Are you sure you want to import the .NET assembly without its dependencies?"
			-- Warning in case user does not ask for importation of assembly dependancies
		indexing
			external_name: "WarningText"
		end

	Window_height: INTEGER is 280
			-- Window height
		indexing
			external_name: "WindowHeight"
		end
		
end -- class IMPORT_DIALOG_DICTIONARY
