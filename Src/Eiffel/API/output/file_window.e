note

	description: "Terminal window that redirects output to a file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FILE_WINDOW

inherit

	OUTPUT_WINDOW

	PLAIN_TEXT_FILE
		rename
			put_string as file_put_string,
			putstring as file_putstring
		end

	PLATFORM
		export
			{NONE} all
		end

create
	make_with_name, make_with_path

feature -- Element change

	put_string (s: READABLE_STRING_GENERAL)
			--
		do
			put_string_general (s)
		end

feature -- Output

	open_file
			-- Open file.
		local
			retried: BOOLEAN
			d: DIRECTORY
		do
			if not retried then
					-- Create recursively the directory in which current is located.
				create d.make_with_path (path.parent)
				if not d.exists then
					d.recursive_create_dir
				end
				open_write
			end;
		rescue
			retried := True;
			retry
		end;

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
