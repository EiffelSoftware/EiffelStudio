indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.ViewDictionary"

class
	VIEW_DICTIONARY
	
inherit
	DIALOG_DICTIONARY

feature -- Access

	Edit_icon: SYSTEM_DRAWING_ICON is
		indexing
			description: "Icon appearing in assembly view and type view header"
			external_name: "EditIcon"
		once
			create Result.make_icon (Edit_icon_filename)
		ensure
			icon_created: Result /= Void
		end

	Edit_icon_filename: STRING is 
		indexing
			description: "Filename of icon appearing in assembly view and type view header"
			external_name: "EditIconFilename"
		once
			Result := Base_filename
			Result := Result.concat_string_string (Result, Edit_icon_relative_filename)
		end
		
	Window_height: INTEGER is 500
		indexing
			description: "Window height"
			external_name: "WindowHeight"
		end	
		
	Window_width: INTEGER is 750
		indexing
			description: "Window width"
			external_name: "WindowWidth"
		end
		
feature {NONE} -- Implementation

	Edit_icon_relative_filename: STRING is "\icon_edit_title_color.ico"
		indexing
			description: "Filename of icon appearing in assembly view and type view header"
			external_name: "EditIconRelativeFilename"
		end
		
end -- class VIEW_DICTIONARY