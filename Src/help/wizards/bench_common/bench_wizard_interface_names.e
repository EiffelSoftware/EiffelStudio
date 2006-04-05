indexing
	description: "All string constants used in the Bench wizards"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BENCH_WIZARD_INTERFACE_NAMES

feature -- Project name and Location state

	t_Project_name_and_location_state: STRING is "Project Name and Project location"

	st_Project_name_and_location_state: STRING is 
		"You can choose the name of the project and%N%
		%the directory where the project will be generated."
		
	m_Project_name_and_location_state: STRING is 
		"Please fill in:%N%
		%%T The name of the project (without spaces).%N%
		%%T The directory where you want the Eiffel classes to be generated."
			
	l_Project_name: STRING is "Project name"
	
	l_Project_location: STRING is "Project location"
	
	l_Compile_project: STRING is "Compile the generated project"
	
feature -- Project name error state

	t_Project_name_error_state: STRING is "Project Name Error"
	
	m_Project_name_error_state: STRING is 
		"The project name that you have specified does not conform%N%
		%to the Lace specification.%N%
		%%N%
		%A valid project name is not empty and only contains letters,%N%
		%digits, and underscores. Moreover the first character must%N%
		%be a letter.%N%
		%%N%
		%Click Back and choose a valid project name."

feature -- Location error state

	t_Location_state: STRING is "Location Error"

	m_Location_state: STRING is 
		"The directory you have chosen doesn't exist and%N%
		%the Wizard cannot create it.%N%
		%%N%
		%Click Back and choose another directory."

feature -- Project warning

	t_Project_already_exist: STRING is "Project already exist"
	
	m_Project_already_exist: STRING is
		"The directory you have chosen already contain%N%
		%a project.%N%
		%%N%
		%Click Back to choose another directory.%N%
		%%N%
		%Click Next to continue and erase actual project.";


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
end -- class BENCH_WIZARD_INTERFACE_NAMES
