indexing
	description: "Provide global functionality to all objects."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"

class
	FACILITIES

inherit
	E_XML_TAGS

feature -- Access

	structure: E_DOCUMENT is 
			-- The help topic tree.
		do
			Result := onces.main_structure
		end

	main_window: VIEWER_WINDOW is
		do
			Result := onces.main_window
		end

	set_main_window(vw:VIEWER_WINDOW) is
		do
			onces.set_main_window(vw)
		end

	set_main_structure(ms:E_DOCUMENT) is
		do
			onces.set_main_structure(ms)
		end

	warning(title, message:STRING; par:EV_CONTAINER) is
		local
			win: EV_WARNING_DIALOG
		do
			!! win.make_with_text(par, title, message)
			win.show
		end

	is_xml_file(fn: STRING):BOOLEAN is
		local
			s: STRING
		do
			s := clone(fn)
			s.tail(4)
			s.to_upper
			Result := s.is_equal(".XML")
		end

	transform_relative_path (path, file: STRING) is
			-- Prepend `file' the path of `path'.
		require
			path_exists: path /= Void
			path_long_enough: path.count > 0
			file_exists: file /= Void
		local
			sep: CHARACTER
		do
			sep := Operating_environment.Directory_separator
			file.prepend (path.substring (1, path.last_index_of (sep, path.count)))
		end

	parse_xml_file (file_name: FILE_NAME): XML_ELEMENT is
			-- Creates a xml-tree-structure from `file_name'.
			-- Wil be Void if an error of any kind occurs.
		require
			file_name_not_void: file_name /= Void
		local
			file: RAW_FILE
			s: STRING
			parser: XML_TREE_PARSER
			err: BOOLEAN
		do
			if not err then
				create parser.make 
				create file.make (file_name)
				if file.exists then
					file.open_read
					file.read_stream (file.count)
					create s.make(file.count)
					s.append (file.last_string)
					parser.parse_string (s)
					parser.set_end_of_file
					file.close
					Result := parser.root_element
				end
			else
				warning ("Error while reading file", "Error while parsing " + file_name, main_window)
			end
		rescue
			err := True
			retry
		end

feature {NONE}

	onces: ONCES is
		once
			create Result
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
end -- class FACILITIES
