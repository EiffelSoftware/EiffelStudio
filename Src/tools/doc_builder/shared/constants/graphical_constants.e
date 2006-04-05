indexing
	description: "Interface Elements, icons, bitmaps, etc."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GRAPHICAL_CONSTANTS

inherit
	APPLICATION_CONSTANTS
	
feature -- Icon constants

	folder_closed_icon: EV_PIXMAP is
			-- Icon for Closing
		local
			l_file: FILE_NAME
		once
			create Result
			create l_file.make_from_string (Icon_resources_directory)
			l_file.extend ("icon_close_folder.ico")
			Result.set_with_named_file (l_file.string)
		end
		
	folder_open_icon: EV_PIXMAP is
			-- Icon for Opening
		local
			l_file: FILE_NAME
		once
			create Result
			create l_file.make_from_string (Icon_resources_directory)
			l_file.extend ("icon_open_file.ico")
			Result.set_with_named_file (l_file.string)
		end
		
	css_file_icon, 
	js_file_icon,
	text_file_icon: EV_PIXMAP is
			-- File icon (text files)
		local
			l_file: FILE_NAME
		once
			create Result
			create l_file.make_from_string (Icon_resources_directory)
			l_file.extend ("icon_format_text_color.ico")
			Result.set_with_named_file (l_file.string)
		end

	xml_file_icon: EV_PIXMAP is
			-- File icon (xml file)
		local
			l_file: FILE_NAME
		once
			create Result
			create l_file.make_from_string (Icon_resources_directory)
			l_file.extend ("icon_format_text_color.ico")
			Result.set_with_named_file (l_file.string)
		end
		
	html_file_icon: EV_PIXMAP is
			-- File icon (html file)
		local
			l_file: FILE_NAME
		once
			create Result
			create l_file.make_from_string (Icon_resources_directory)
			l_file.extend ("icon_html_file.ico")
			Result.set_with_named_file (l_file.string)
		end

	png_file_icon: EV_PIXMAP is
			-- File icon (png file)
		local
			l_file: FILE_NAME
		once
			create Result
			create l_file.make_from_string (Icon_resources_directory)
			l_file.extend ("icon_png_file.ico")
			Result.set_with_named_file (l_file.string)
		end
		
	jpg_file_icon: EV_PIXMAP is
			-- File icon (jpg file)
		local
			l_file: FILE_NAME
		once
			create Result
			create l_file.make_from_string (Icon_resources_directory)
			l_file.extend ("icon_jpeg_file.ico")
			Result.set_with_named_file (l_file.string)
		end

	gif_file_icon: EV_PIXMAP is
			-- File icon (gif file)
		local
			l_file: FILE_NAME
		once
			create Result
			create l_file.make_from_string (Icon_resources_directory)
			l_file.extend ("icon_gif_file.ico")
			Result.set_with_named_file (l_file.string)
		end

feature -- Color constants

	tag_color: EV_COLOR is
			-- Color for tags (<,>,=,/,")
		once
			create Result.make_with_rgb (0.0, 0.0, 1.0)	
		end		

	element_color: EV_COLOR is
			-- Color for elements
		once
			create Result.make_with_rgb (1.0, 0.0, 0.0)	
		end		
		
	attribute_color: EV_COLOR is
			-- Color for attributes
		once
			create Result.make_with_rgb (203, 203, 152)	
		end		

	content_color: EV_COLOR is
			-- Color for attributes
		once
			Result := (create {EV_STOCK_COLORS}).black
		end	

	white: EV_COLOR is
			-- Color for attributes
		once
			Result := (create {EV_STOCK_COLORS}).white
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
end -- class GRAPHICAL_CONSTANTS
