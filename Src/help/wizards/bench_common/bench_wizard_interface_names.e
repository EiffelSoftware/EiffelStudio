note
	description: "All string constants used in the Bench wizards"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BENCH_WIZARD_INTERFACE_NAMES

inherit
	WIZARD_SHARED

feature -- Project name and Location state

	t_Project_name_and_location_state: STRING_GENERAL do Result := locale.translation ("Project Name and Project location") end

	st_Project_name_and_location_state: STRING_GENERAL
		do Result := locale.translation ("You can choose the name of the project and%N%
		%the directory where the project will be generated.") end

	m_Project_name_and_location_state: STRING_GENERAL
		do Result := locale.translation ("Please fill in:%N%
		%%T The name of the project (without spaces).%N%
		%%T The directory where you want the Eiffel classes to be generated.") end

	l_Project_name: STRING_GENERAL do Result := locale.translation ("Project name") end

	l_Project_location: STRING_GENERAL do Result := locale.translation ("Project location") end

	l_Compile_project: STRING_GENERAL do Result := locale.translation ("Compile the generated project") end

feature -- Project name error state

	t_Project_name_error_state: STRING_GENERAL do Result := locale.translation ("Project Name Error") end

	m_Project_name_error_state: STRING_GENERAL
		do Result := locale.translation ("The project name that you have specified does not conform%N%
		%to the Lace specification.%N%
		%%N%
		%A valid project name is not empty and only contains letters,%N%
		%digits, and underscores. Moreover the first character must%N%
		%be a letter.%N%
		%%N%
		%Click Back and choose a valid project name.") end

feature -- Location error state

	t_Location_state: STRING_GENERAL do Result := locale.translation ("Location Error") end

	m_Location_state: STRING_GENERAL
		do Result := locale.translation ("The directory you have chosen doesn't exist and%N%
		%the Wizard cannot create it.%N%
		%%N%
		%Click Back and choose another directory.") end

feature -- Project warning

	t_Project_already_exist: STRING_GENERAL do Result := locale.translation ("Project already exists") end

	m_Project_already_exist: STRING_GENERAL
		do Result := locale.translation ("The directory you have chosen already contain%N%
		%a project.%N%
		%%N%
		%Click Back to choose another directory.%N%
		%%N%
		%Click Next to continue and erase actual project.") end;

feature -- Files warning

	t_Files_already_exist: STRING_GENERAL do Result := locale.translation ("Files already exist") end

	m_Files_already_exist (n: STRING_GENERAL): STRING_GENERAL
		do
			Result := locale.formatted_string (
				"[
					The project directory already contains the following files
					that are about to be generated:$1
					
					Click Back to rename a project and to choose another directory.
					
					Click Next to continue and to replace existing files with the new ones.
				]",
				[n]
			)
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
end -- class BENCH_WIZARD_INTERFACE_NAMES
