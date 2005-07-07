indexing
	description: "Icons for drag and drop in editor."
	date: "$Date$"
	revision: "$Revision$"

class
	DOC_BUILDER_CURSORS
	
inherit
	EDITOR_CURSORS
	
	SHARED_CONSTANTS
	
feature -- Cursor

	cur_cut_selection: EV_CURSOR is
		once
			Result := cursor_file_content ("cut_selection")
			Result.set_x_hotspot (0)
			Result.set_y_hotspot (0)
		end

	cur_copy_selection: EV_CURSOR is
		once
			Result := cursor_file_content ("copy_selection")
			Result.set_x_hotspot (0)
			Result.set_y_hotspot (0)
		end

feature {NONE} -- Implementation

	cursor_file_content (fn: STRING): EV_CURSOR is
			-- Load the cursor contained in file `fn'.ico or `fn'.xpm, depending on the platform.
		local
			full_path: FILE_NAME
			retried: BOOLEAN
			a_pix: EV_PIXMAP
		do
				-- Create the pixmap
			create a_pix

			if not retried then
					-- Initialize the pathname & load the file
				create full_path.make_from_string (application_constants.cursor_resources_directory)
				full_path.set_file_name (fn)
				full_path.add_extension ("png")
				a_pix.set_with_named_file (full_path)
			else
				io.error.put_string ("Warning: cannot read pixmap file ")
				io.error.put_string (full_path)
				io.error.put_new_line
				a_pix.set_size (20, 20) -- Default pixmap size
			end
			create Result.make_with_pixmap (a_pix, a_pix.width // 2, a_pix.height // 2)
		rescue
			retried := True
			retry
		end

end
