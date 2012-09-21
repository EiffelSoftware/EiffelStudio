note
	description:
		"Error when a precompiled file or directory cannot be read."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VD42

inherit

	LACE_ERROR
		redefine
			build_explain
		end

feature -- Properties

	path: READABLE_STRING_GENERAL
			-- Path of file/directory

	is_directory: BOOLEAN

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
		do
			if is_directory then
				a_text_formatter.add ("Directory: ")
			else
				a_text_formatter.add ("File: ")
			end
			a_text_formatter.add (path)
			a_text_formatter.add_new_line
		end

feature {REMOTE_PROJECT_DIRECTORY} -- Setting

	set_path (s: like path)
			-- Assign `s' to `path'.
		do
			path := s
		end

	set_is_directory
		do
			is_directory := True
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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

end -- class VD42
