indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.EiffelGenerationDialogDictionary"

class
	EIFFEL_GENERATION_DIALOG_DICTIONARY

inherit
	GENERATION_DIALOG_DICTIONARY
	
feature -- Access
	
	Assembly_generation_message: STRING is "Generating Eiffel classes..."
		indexing
			description: "Message to let the user know selected assembly will be generated to the Eiffel repository"
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

	Eiffel_generation_icon_filename: STRING is
		indexing
			description: "Filename of icon appearing in Eiffel generation dialog header"
			external_name: "EiffelGenerationIconFilename"
		once
			Result := Base_filename
			Result := Result.concat_string_string (Result, Eiffel_generation_icon_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: Result.get_length > 0
		end
		
	Title: STRING is "Generate Eiffel classes"
		indexing
			description: "Window title"
			external_name: "Title"
		end

	Window_height: INTEGER is 300
		indexing
			description: "Window height"
			external_name: "WindowHeight"
		end

feature {NONE} -- Implementation

	Eiffel_generation_icon_relative_filename: STRING is "\icon_export_to_eiffel_color.ico"
		indexing
			description: "Filename of icon appearing in Eiffel generation dialog header"
			external_name: "EiffelGenerationIconRelativeFilename"
		end

end -- class EIFFEL_GENERATION_DIALOG_DICTIONARY
