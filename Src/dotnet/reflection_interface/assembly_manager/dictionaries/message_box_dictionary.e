indexing
	description: "Useful constants for message boxes"
	external_name: "ISE.AssemblyManager.MessageBoxDictionary"

class
	MESSAGE_BOX_DICTIONARY

inherit
	DIALOG_DICTIONARY

feature -- Access

	Image_height: INTEGER is 250
		indexing
			description: "Image height"
			external_name: "ImageHeight"
		end
	
	Image_width: INTEGER is 150
		indexing
			description: "Image width"
			external_name: "ImageWidth"
		end
		
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

	Watch_pixmap_not_found_error: STRING is 
		indexing
			description: "Error message in case the watch pixmap was not found"
			external_name: "WatchPixmapNotFoundError"
		once
			Result ?= Pixmap_not_found_error_part_1.clone
			Result := Result.concat_string_string_string (Result, Watch_icon_filename, Pixmap_not_found_error_part_2)			
		ensure
			non_void_message: Result /= Void
			not_empty_message: Result.get_length > 0
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