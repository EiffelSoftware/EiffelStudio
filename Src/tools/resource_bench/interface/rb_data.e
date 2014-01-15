note
	description: "Data for resource bench"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	RB_DATA

feature -- Access

	Title: STRING = "Resource Bench"
			-- Window's title.

	Help_file: STRING = "rb.hlp"
			-- Name of the help file.

	Grammar_name: STRING = "rb.gram"
			-- Name of the grammar file.

	Tmp_directory: PATH
			-- Name of the temporary directory.
		once
			create Result.make_from_string ("C:\temp")
		end

	application_directory: PATH
			-- Path to the application directory.

	working_directory: PATH
			-- Path to the current directory.

feature -- Element change

	set_application_directory (a_path: like application_directory)
			-- Set `application_directory' to `a_path'.
		require
			a_path_not_void: a_path /= Void
			a_path_exists: not a_path.is_empty
		do
			application_directory := a_path
		ensure
			application_directory_set: application_directory.is_equal (a_path)
		end

	set_working_directory (a_path: like working_directory)
			-- Set `working_directory' to `a_path'.
		require
			a_path_not_void: a_path /= Void
			a_path_exists: not a_path.is_empty
		do
			working_directory := a_path
		ensure
			working_directory_set: working_directory.is_equal (a_path)
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
end -- class RB_DATA
