class
    EDITOR_ICONS

feature -- Cursor

	header_left_scroll_pixmap: EV_PIXMAP is
		once
			Result := pixmap_file_content ("right_scroll_arrow")
		end

	header_right_scroll_pixmap: EV_PIXMAP is
		once
			Result := pixmap_file_content ("left_scroll_arrow")
		end
		
	header_close_current_document_pixmap: EV_PIXMAP is
		once
			Result := pixmap_file_content ("icon_close_color")
		end

feature -- Status Setting

	set_editor_installation_dir_name (a_loc: like icons_path) is
			-- Set `icon_path'.
		require
			loc_not_void: a_loc /= Void
		do
			icons_path := a_loc
		ensure
			icon_path_set: icons_path = a_loc
		end		

feature {NONE} -- Implementation

	icons_path: DIRECTORY_NAME
			-- Location of icon pixmaps.  Default: Void.  Set it with `set_editor_installation_dir_name'.

	pixmap_file_content (fn: STRING): EV_PIXMAP is
			-- Create a pixmap and initialize it with contents of file `fn'.ico or `fn'.xpm.
		local
			full_path: FILE_NAME
			retried: BOOLEAN
		do
				-- Create the pixmap
			create Result

			if not retried then
					-- Initialize the pathname & load the file
				create full_path.make_from_string (icons_path)
				full_path.set_file_name (fn)
				full_path.add_extension ("png")
				Result.set_with_named_file (full_path)
			else
				io.error.put_string ("Warning: cannot read pixmap file ")
				io.error.put_string (full_path)
				io.error.put_new_line
				Result.set_size (20, 20) -- Default pixmap size
			end
		rescue
			retried := True
			retry
		end
		
end -- class EDITOR_ICONS