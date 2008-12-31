note
	description: "Constants for Table of Contents."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_OF_CONTENTS_CONSTANTS

feature -- HTML Help 1.x

	html_help_header: STRING = "<HTML>%N<HEAD>%N</HEAD><BODY>%N"

	html_help_footer: STRING = "</UL></BODY></HTML>"
	
	icon_type_text: STRING = "<OBJECT type=%"text/site properties%"><param name=%"Window Styles%" value=%"0x800025%"></OBJECT>"
			-- Uses folders instead of books
	
feature -- File	
	
	default_url: STRING = "index.xml"
			-- Url identifier to be used for folder nodes (i.e "index.xml"), if any
			
	xml_extension: STRING = "xml"
			-- XML extension
			
feature -- Pixmaps

	folder_closed_icon: EV_PIXMAP
			-- Icon for Closing
		local
			l_file: FILE_NAME
		once
			create Result
			create l_file.make_from_string (Constants.Icon_resources_directory)
			l_file.extend ("icon_toc_folder_closed.ico")
			Result.set_with_named_file (l_file.string)
		end
		
	folder_open_icon: EV_PIXMAP
			-- Icon for Opening
		local
			l_file: FILE_NAME
		once
			create Result
			create l_file.make_from_string (Constants.Icon_resources_directory)
			l_file.extend ("icon_toc_folder_open.ico")
			Result.set_with_named_file (l_file.string)
		end
		
	file_icon: EV_PIXMAP
			-- File icon
		local
			l_file: FILE_NAME
		once
			create Result
			create l_file.make_from_string (Constants.Icon_resources_directory)
			l_file.extend ("icon_format_text_color.ico")
			Result.set_with_named_file (l_file.string)
		end	
			
feature -- XML tags			
			
	id_string: STRING = "id"
			
	title_string: STRING = "title"
	
	url_string: STRING = "url"
	
	icon_string: STRING = "icon"
	
	topic_string: STRING = "topic"
	
	heading_string: STRING = "heading"
	
	root_string: STRING = "table_of_contents"

feature -- Id generation

	unique_id: TUPLE [INTEGER]
			-- Unique node id, starts at 1
		once
			create Result
			Result.put_integer (1, 1)
		end

	next_id: INTEGER
			-- Next unique id
		do
			Result := unique_id.integer_item (1) + 1
			set_unique_id (Result)
		end
		
	set_unique_id (a_id: INTEGER)
			-- Set the unique id
		do
			unique_id.put_integer (a_id, 1)
		end		
		
feature {NONE} -- Implementation		
		
	Constants: APPLICATION_CONSTANTS
			-- Constants
		once
			create Result
		end		

note
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
end -- class TABLE_OF_CONTENTS_CONSTANTS
