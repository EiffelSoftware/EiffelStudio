indexing
	description: "Icons for drag and drop in editor."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
