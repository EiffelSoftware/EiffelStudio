note
	description: "Features to create/manipulate directories and directory names"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	ISE_DIRECTORY_UTILITIES

inherit
	ANY

	EXCEPTIONS
		export
			{NONE} all
		end

feature -- Basic operations

	path_ellipsis (a_path: STRING_32; a_max_length: INTEGER): STRING_32
			-- Create the displayed string of `a_path', with a maximum
			-- length of `a_max_length' characters. If `a_path' is
			-- longer than `a_max_length', we only keep the beginning
			-- and the end of the pathname, and we put "..." in the
			-- middle.
			-- A typical `Result' of this feature is "C:\...\EIFGEN\W_code\TRANSLAT"
		require
			a_path_valid: a_path /= Void
			a_max_length_valid: a_max_length > 0
		local
			slash_index: INTEGER
			cur_length: INTEGER
			a_path_count: INTEGER
			loc_directory_separator: CHARACTER
		do
				-- Initialize local/cached variables
			a_path_count := a_path.count
			loc_directory_separator := operating_environment.directory_separator

			if a_max_length >= a_path.count then
				create Result.make_from_string (a_path)
			else
				create Result.make (a_max_length)
				slash_index := a_path.index_of (loc_directory_separator, 1)
				Result.append (a_path.substring (1, slash_index))
				Result.append ("...")
				cur_length := a_max_length - slash_index - 3
				from until
					a_path.count - slash_index < cur_length or
					slash_index = 0
				loop
					slash_index := a_path.index_of (loc_directory_separator, slash_index + 1)
				end

				if slash_index /= 0 then
						-- We build a path like "C:\...\Dir\Dir\File"
					Result.append (a_path.substring (slash_index, a_path.count))
				else
						-- We can't build the same path as above (not enoug room) so
						-- we will only display the file name (the beginning at least)
					Result := a_path.substring (a_path.last_index_of (loc_directory_separator, a_path.count) + 1, a_path.count)
					if Result.count > a_max_length then
						Result := Result.substring (1, a_max_length)
					end
				end
			end
		ensure
			Result_not_void: Result /= Void
			Result_length_not_bigger_than_maximum: Result.count <= a_max_length
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
