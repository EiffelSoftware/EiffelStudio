indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.Dictionary"

class
	DICTIONARY

feature -- Access

	Abort_retry_ignore_message_box_buttons: INTEGER is 2
		indexing
			description: "Abort/Retry/Ignore message box buttons"
			external_name: "AbortRetryIgnoreMessageBoxButtons"
		end

	Access_violation_error: STRING is "The Eiffel Assembly Cache is currently accessed by another process. Do you want to force access anyway?%N%N%
						%- Abort: To close this dialog without doing anything.%N%
						%- Retry: To retry in case the other process has exited.%N%
						%- Ignore: To ignore the access violation and force access to the Eiffel Assembly Cache."
		indexing
			description: "Message to the user in case there is a write or read lock in the currently accessed assembly folder"
			external_name: "AccessViolationError"
		end
		
	Assembly_manager_icon: SYSTEM_DRAWING_ICON is
		indexing
			description: "Icon appearing in dialogs header"
			external_name: "AssemblyManagerIcon"
		once
			create Result.make_icon (Assembly_manager_icon_filename)
		ensure
			icon_created: Result /= Void
		end

	Assembly_manager_icon_filename: STRING is 
		indexing
			description: "Filename of icon appearing in dialogs header"
			external_name: "AssemblyManagerIconFilename"
		once
			Result := Base_filename
			Result := Result.concat_string_string (Result, Assembly_manager_icon_relative_filename)
		ensure
			filename_created: Result /= Void
			not_empty_filename: Result.get_length > 0
		end

	Base_filename: STRING is
		indexing
			description: "Path to folder where icons are stored"
			external_name: "BaseRelativeFilename"
		local
			support: ISE_REFLECTION_REFLECTIONSUPPORT
		once
			create support.make_reflectionsupport
			support.make
			Result := support.Eiffel_delivery_path
			Result := Result.concat_string_string (Result, Base_relative_filename)
		end

	Base_relative_filename: STRING is "\bench\wizards\new_projects\dotnet\pixmaps\"
		indexing
			description: "Path to folder where icons are stored"
			external_name: "BaseRelativeFilename"
		end
						
	Button_height: INTEGER is 27
		indexing
			description: "Button height"
			external_name: "ButtonHeight"
		end
		
	Button_width: INTEGER is 73
		indexing
			description: "Width of current buttons"
			external_name: "ButtonWidth"
		end

	Confirmation_caption: STRING is "Confirmation - ISE Assembly Manager"
		indexing
			description: "Caption for confirmation message boxes"
			external_name: "ConfirmationCaption"
		end
		
	Error_caption: STRING is "ERROR - ISE Assembly Manager"
		indexing
			description: "Caption for error message boxes"
			external_name: "ErrorCaption"
		end
			
	Font_family_name: STRING is "Verdana"
		indexing
			description: "Name of label font family"
			external_name: "FontFamilyName"
		end

	Font_size: REAL is 8.0
		indexing
			description: "Font size"
			external_name: "FontSize"
		end
		
	Information_caption: STRING is "Information - ISE Assembly Manager"
		indexing
			description: "Caption for information message boxes"
			external_name: "InformationCaption"
		end
				
	Label_font_size: REAL is 10.0
		indexing
			description: "Label font size"
			external_name: "LabelFontSize"
		end

	Label_height: INTEGER is 20
		indexing
			description: "Label height"
			external_name: "LabelHeight"
		end
		
	Margin: INTEGER is 10
		indexing
			description: "Margin"
			external_name: "Margin"
		end

	
	Pixmap_not_found_error: STRING is
		indexing
			description: "Error message in case the dialog pixmap has not been found"
			external_name: "PixmapNotFoundError"
		once
			Result ?= Pixmap_not_found_error_part_1.clone
			Result := Result.concat_string_string_string (Result, Assembly_manager_icon_filename, Pixmap_not_found_error_part_2)
		ensure
			non_void_message: Result /= Void
			not_empty_message: Result.get_length > 0
		end
			
feature {NONE} -- Implementation

	Assembly_manager_icon_relative_filename: STRING is "icon_dotnet_wizard_color.ico"
		indexing
			description: "Filename of icon appearing in dialogs header"
			external_name: "AssemblyManagerIconRelativeFilename"
		end

	Pixmap_not_found_error_part_1: STRING is "The pixmap "
		indexing
			description: "First part of the error message in case a pixmap has not been found"
			external_name: "PixmapNotFoundErrorPart1"
		end
		
	Pixmap_not_found_error_part_2: STRING is " was not found. Please reinstall the Eiffel delivery."
		indexing
			description: "Second part of the error message in case a pixmap has not been found"
			external_name: "PixmapNotFoundErrorPart2"
		end	
		
end -- class DICTIONARY