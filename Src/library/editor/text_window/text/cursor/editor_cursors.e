class
    EDITOR_CURSORS

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

feature -- Status Setting

	set_editor_installation_dir_name (a_loc: like cursor_path) is
			-- Set `cursor_path'.
		require
			loc_not_void: a_loc /= Void
		do
			cursor_path := a_loc
		ensure
			cursor_path_set: cursor_path = a_loc
		end		

feature {NONE} -- Implementation

	cursor_path: DIRECTORY_NAME
			-- Location of cursor pixmaps.  Default: Void.  Set it with `set_editor_installation_dir_name'.

	cursor_file_content (fn: STRING): EV_CURSOR is
			-- Load the cursor contained in file `fn'.ico or `fn'.xpm, depending on the platform.
		local
			a_pix: EV_PIXMAP
		do
			a_pix := pixmap_file_content (fn)
			create Result.make_with_pixmap (a_pix, a_pix.width // 2, a_pix.height // 2)
		end

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
				create full_path.make_from_string (Cursor_path)
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
		
end -- class EDITOR_CURSORS