indexing
	description: "Useful constants for message boxes"
	external_name: "ISE.AssemblyManager.MessageBoxDictionary"

class
	MESSAGE_BOX_DICTIONARY

inherit
	DIALOG_DICTIONARY

feature -- Access

	Other_message: STRING is "This may take a few minutes. Please be patient."
		indexing
			description: "Other message"
			external_name: "OtherMessage"
		end
		
	Title: STRING is "ISE Assembly Manager"
		indexing
			description: "Window title"
			external_name: "Title"
		end
	
	Window_height: INTEGER is 120
		indexing
			description: "Window height"
			external_name: "WindowHeight"
		end
	
	Window_width: INTEGER is 400
		indexing
			description: "Window width"
			external_name: "WindowWidth"
		end

	Watch_icon_filename: STRING is 
		indexing
			description: "Filename of icon on the right side of the message box"
			external_name: "WatchIconFilename"
		once
			Result := Base_filename
			Result := Result.concat_string_string (Result, Watch_icon_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: Result.get_length > 0
		end

feature {NONE} -- Implementation
		
	Watch_icon_relative_filename: STRING is "icon_watch_color.ico"
		indexing
			description: "Filename of icon on the right side of the message box"
			external_name: "WatchIconRelativeFilename"			
		end
		
end -- MESSAGE_BOX_DICTIONARY