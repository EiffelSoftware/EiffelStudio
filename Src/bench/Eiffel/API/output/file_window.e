indexing

	description:
		"Terminal window that redirects output to a file."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class FILE_WINDOW

inherit

	OUTPUT_WINDOW

	PLAIN_TEXT_FILE

	PLATFORM_CONSTANTS

create

	make

feature -- Output

	open_file is
			-- Open file.
		local
			retried: BOOLEAN
			i, nb: INTEGER
			sub_name: STRING
			d: DIRECTORY
			c: CHARACTER
		do
			if not retried then
					-- Create recursively the file name
				from
					c := Directory_separator
					if is_windows then
							-- For Windows we can have either `c:\' and the existence
							-- does work on `c:\' only, not on `c:'. So we have to search
							-- until the next `Directory_separator'.
						i := name.index_of (':', 1)
					end
					i := name.index_of (c, i + 2)
					nb := name.count
				until
					i = 0
				loop
					sub_name := name.substring (1, i - 1)
					create d.make (sub_name)
					if not d.exists then
						d.create_dir
					end
					i := name.index_of (c, i + 2)
				end
				open_write
			end;
		rescue
			retried := True;
			retry
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class FILE_WINDOW
