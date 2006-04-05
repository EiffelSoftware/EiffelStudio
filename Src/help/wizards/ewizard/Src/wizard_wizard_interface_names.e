indexing
	description: "All string constants used in the Wizard wizard"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WIZARD_INTERFACE_NAMES

feature -- Initial state

	t_Initial_state: STRING is
		"Welcome to the New Wizard%NApplication Wizard"
		
	m_Initial_state: STRING is
		"Using this wizard you can create a Wizard application%N%
		%%N%
		%You will have to choose how many states should be in%N%
		%your wizard.%N%
		%Then all the useful classes will be generated, and you will%N%
		%just have to fill in the WIZARD_xxxx_STATE classes.%N%
		%%N%
		%%N%
		%To continue, click Next."
		
feature -- Second state

	t_Second_state: STRING is "Number of States"
		
	st_Second_state: STRING is "You can choose the number of states your wizard will have."
	
	m_Second_state: STRING is "The number of states is limited to 10."
	
	l_Number_of_state1: STRING is "Generate a wizard with "
		
	l_Number_of_state2: STRING is " states."
	
feature -- Final state

	t_Final_state: STRING is "Completing the New Wizard %NApplication Wizard"
	
	m_Final_state (compile_project: BOOLEAN; project_name: STRING; project_location: STRING): STRING is
		local
			word: STRING
		do
			if compile_project then
				word := "and compile "
			else
				word := ""
			end
			Result := "You have specified the following settings:%N%
				%%N%
				%Project name: %T" + project_name + "%N%
				%Location:     %T" + project_location + "%N%
				%%N%
				%%N%
				%Click Finish to generate " + word + "this project"
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
end -- class WIZARD_WIZARD_INTERFACE_NAMES
