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

	Access_violation_error: STRING is "[The Eiffel Assembly Cache is currently accessed by another process. Do you want to force access anyway?%N%N%
						%- Abort: To close this dialog without doing anything.%N%
						%- Retry: To retry in case the other process has exited.%N%
						%- Ignore: To ignore the access violation and force access to the Eiffel Assembly Cache.]"
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
			not_empty_filename: Result.length > 0
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
			Result := support.Eiffeldeliverypath
			Result := Result.concat_string_string (Result, Base_relative_filename)
		end

	Base_relative_filename: STRING is "\bench\wizards\new_projects\dotnet\pixmaps\"
		indexing
			description: "Path to folder where icons are stored"
			external_name: "BaseRelativeFilename"
		end
		
	Border_style: INTEGER is 3
		indexing
			description: "Window border style: a fixed, single line border"
			external_name: "BorderStyle"
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
	
	Error_icon: INTEGER is 16
		indexing
			description: "Icon for error message boxes"
			external_name: "ErrorIcon"
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

	Ignore_result: INTEGER is 5
		indexing
			description: "Returned value in case user clicked on `Ignore'"
			external_name: "IgnoreResult"
		end
		
	Information_caption: STRING is "Information - ISE Assembly Manager"
		indexing
			description: "Caption for information message boxes"
			external_name: "InformationCaption"
		end
		
	Information_icon: INTEGER is 64
		indexing
			description: "Icon for information message boxes"
			external_name: "InformationIcon"
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

	Ok_cancel_message_box_buttons: INTEGER is 1
		indexing
			description: "OK and Cancel message box buttons"
			external_name: "OkCancelMessageBoxButtons"
		end
		
	Ok_message_box_button: INTEGER is 0
		indexing
			description: "OK message box button"
			external_name: "OkMessageBoxButton"
		end
	
	Regular_style: INTEGER is 0
		indexing
			description: "Regular style"
			external_name: "RegularStyle"
		end

	Retry_result: INTEGER is 4
		indexing
			description: "Returned value in case user clicked on `Retry'"
			external_name: "RetryResult"
		end
		
feature {NONE} -- Implementation

	Assembly_manager_icon_relative_filename: STRING is "\icon_dotnet_wizard_color.ico"
		indexing
			description: "Filename of icon appearing in dialogs header"
			external_name: "AssemblyManagerIconRelativeFilename"
		end
		
end -- class DICTIONARY