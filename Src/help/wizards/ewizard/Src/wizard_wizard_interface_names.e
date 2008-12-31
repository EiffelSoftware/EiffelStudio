note
	description: "All string constants used in the Wizard wizard"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WIZARD_INTERFACE_NAMES

inherit
	WIZARD_SHARED

feature -- Title

	t_Initial_state: STRING_GENERAL
		do Result := locale.translation ("Welcome to the New Wizard%NApplication Wizard") end

	t_Final_state: STRING_GENERAL do Result := locale.translation ("Completing the New Wizard %NApplication Wizard") end

	t_Second_state: STRING_GENERAL do Result := locale.translation ("Number of States") end

	st_Second_state: STRING_GENERAL do Result := locale.translation ("You can choose the number of states your wizard will have.") end

	t_new_wizard_application_wizard: STRING_GENERAL do Result := locale.translation ("New Wizard Application Wizard") end

feature -- Label

	l_Number_of_state1: STRING_GENERAL do Result := locale.translation ("Generate a wizard with ") end

	l_Number_of_state2: STRING_GENERAL do Result := locale.translation (" states.") end

feature -- Message

	m_Final_state (compile_project: BOOLEAN; project_name: STRING_GENERAL; project_location: STRING_GENERAL): STRING_GENERAL
		local
			word: STRING_32
		do
			word := locale.formatted_string (locale.translation (
				"You have specified the following settings:%N%
				%%N%
				%Project name: %T$1%N%
				%Location:     %T$2%N%
				%%N%
				%%N"),
				[project_name, project_location])
			if compile_project then
				Result := word + locale.translation ("Click Finish to generate and compile this project")
			else
				Result := word + locale.translation ("Click Finish to generate this project")
			end
		end

	m_Initial_state: STRING_GENERAL
		do Result := locale.translation ("Using this wizard you can create a Wizard application%N%
		%%N%
		%You will have to choose how many states should be in%N%
		%your wizard.%N%
		%Then all the useful classes will be generated, and you will%N%
		%just have to fill in the WIZARD_xxxx_STATE classes.%N%
		%%N%
		%%N%
		%To continue, click Next.") end

	m_Second_state: STRING_GENERAL do Result := locale.translation ("The number of states is limited to 10.") end;

note
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
