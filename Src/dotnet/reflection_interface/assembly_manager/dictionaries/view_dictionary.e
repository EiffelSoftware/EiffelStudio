indexing
	description: "Useful constants for assembly manager"
	external_name: "ISE.AssemblyManager.ViewDictionary"

class
	VIEW_DICTIONARY
	
inherit
	DIALOG_DICTIONARY
		redefine
			Pixmap_not_found_error
		end

feature -- Access

	Edit_icon: DRAWING_ICON is
		indexing
			description: "Icon appearing in assembly view and type view header"
			external_name: "EditIcon"
		once
			create Result.make_drawing_icon (Edit_icon_filename.to_cil)
		ensure
			icon_created: Result /= Void
		end

	Edit_icon_filename: STRING is 
		indexing
			description: "Filename of icon appearing in assembly view and type view header"
			external_name: "EditIconFilename"
		once
			Result := Base_filename.clone (Base_filename)
			Result.append (Edit_icon_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: Result.count > 0
		end

	Pixmap_not_found_error: STRING is
		indexing
			description: "Error message in case the dialog pixmap has not been found"
			external_name: "PixmapNotFoundError"
		once
			Result := Pixmap_not_found_error_part_1.clone (Pixmap_not_found_error_part_1)
			Result.append (Edit_icon_filename)
			Result.append (Pixmap_not_found_error_part_2)
		ensure
			non_void_message: Result /= Void
			not_empty_message: Result.count > 0
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