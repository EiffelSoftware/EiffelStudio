indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.EiffelGenerationDialogDictionary"

class
	EIFFEL_GENERATION_DIALOG_DICTIONARY

inherit
	GENERATION_DIALOG_DICTIONARY
	
feature -- Access
	
	Assembly_generation_message: STRING is "The assembly manager will now generate the Eiffel classes corresponding to the selected assembly. This may take a few minutes. Please be patient."
			-- Message to let the user know selected assembly will be generated to the Eiffel repository.
		indexing
			external_name: "AssemblyGenerationMessage"
		end

	Eiffel_generation_icon: SYSTEM_DRAWING_ICON is
		indexing
			description: "Icon appearing in Eiffel generation dialog header"
			external_name: "EiffelGenerationIcon"
		once
			create Result.make_icon (Eiffel_generation_icon_filename)
		ensure
			icon_created: Result /= Void
		end
				
	Eiffel_generation_error: STRING is "An errors occurred during Eiffel code generation. The XML files may be corrupted. Please remove the assembly and import it again: the Eiffel code will be automatically generated at importation."
		indexing
			description: "Error message when Eiffel code generation fails"
			external_name: "EiffelGenerationError"
		end

	Eiffel_generation_icon_filename: STRING is "F:\Src\dotnet\reflection_interface\assembly_manager\icons\icon_export_to_eiffel_color.ico"
		indexing
			description: "Filename of icon appearing in Eiffel generation dialog header"
			external_name: "EiffelGenerationIconFilename"
		end

	Title: STRING is "Generate Eiffel classes"
			-- Window title
		indexing
			external_name: "Title"
		end

	Window_height: INTEGER is 275
			-- Window height
		indexing
			external_name: "WindowHeight"
		end
		
end -- class EIFFEL_GENERATION_DIALOG_DICTIONARY
