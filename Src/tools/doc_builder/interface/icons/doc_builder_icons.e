indexing
	description: "Icons for header control"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOC_BUILDER_ICONS

inherit
	EDITOR_ICONS
	
	SHARED_CONSTANTS

feature -- Icons

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

feature {NONE} -- Implementation

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
				create full_path.make_from_string (application_constants.icon_resources_directory)
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
