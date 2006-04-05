indexing
	description:
		"File names for which the separator can be changed. Used for%N%
		%platform specific or HTML file generation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "brendel"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FILE_NAME

inherit
	FILE_NAME
		redefine
			extend,
			set_subdirectory,
			set_directory
		end

create
	make,
	make_from_string

create {EB_FILE_NAME}
	string_make

feature -- Status setting

	set_separator (a_sep: CHARACTER) is
			-- Use `a_sep' as separator.
		require
			a_sep_not_null: a_sep /= '%U'
			a_sep_slash_or_backslash: a_sep = '\' or a_sep = '/'
		do
			sep := a_sep
			replace_all
		end

	set_slash_separator is
			-- Override separator use to `/'.
		do
			sep := '/'
			replace_all
		end

	set_backslash_separator is
			-- Override separator use to `\'.
		do
			sep := '\'
			replace_all
		end

	set_platform_separator is
			-- Use default platform separator.
		do
			if sep /= '%U' then
				sep := (create {OPERATING_ENVIRONMENT}).Directory_separator
				replace_all
				sep := '%U'
			end
		end

feature -- Element change

	extend (directory_name: STRING) is
			-- Append the subdirectory `directory_name' to the path name.
		do
			Precursor (directory_name)
			if sep /= '%U' then
				replace_all
			end
		end

	set_subdirectory (directory_name: STRING) is
			-- Append the subdirectory `directory_name' to the path name.
		do
			extend (directory_name)
		end

	set_directory (directory_name: STRING) is
			-- Set the absolute directory part of the path name to `directory_name'.
		do
			Precursor (directory_name)
			if sep /= '%U' then
				replace_all
			end
		end

feature {NONE} -- Implementation

	replace_all is
			-- Replace separators if necessary.
		require
			sep_not_null: sep /= '%U'
		local
			i : INTEGER
		do
			if not is_empty then
				from i := 1 until i = 0 loop
					i := index_of (other, i)
					if i > 0 then
						put (sep, i)
					end
				end
			end
		end

	sep: CHARACTER
			-- Used as directory separator.
			-- '%U' means use platform character.

	other: CHARACTER is
			-- The reverse slash of `sep'.
		require
			sep_not_null: sep /= '%U'
		do
			if sep.is_equal ('\') then
				Result := '/'
			elseif sep.is_equal ('/') then
				Result := '\'
			end
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

end -- class EB_FILE_NAME
