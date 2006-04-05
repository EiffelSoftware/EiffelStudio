indexing
	description: "Data for resource bench"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	RB_DATA

feature -- Access

	Title: STRING is "Resource Bench"
			-- Window's title.

	Help_file: STRING is "rb.hlp"
			-- Name of the help file.

	Grammar_name: STRING is "rb.gram"
			-- Name of the grammar file.

	Tmp_directory: STRING is "c:\temp"
			-- Name of the temporary directory.

	application_directory: STRING
			-- Path to the application directory.

	working_directory: STRING
			-- Path to the current directory.

feature -- Element change

	set_application_directory (a_path: STRING) is
			-- Set `application_directory' to `a_path'.
		require
			a_path_not_void: a_path /= Void
			a_path_exists: a_path.count > 0
		do
			application_directory := a_path.twin
		ensure
			application_directory_set: application_directory.is_equal (a_path)
		end

	set_working_directory (a_path: STRING) is
			-- Set `working_directory' to `a_path'.
		require
			a_path_not_void: a_path /= Void
			a_path_exists: a_path.count > 0
		do
			working_directory := a_path.twin
		ensure
			working_directory_set: working_directory.is_equal (a_path)
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
end -- class RB_DATA
