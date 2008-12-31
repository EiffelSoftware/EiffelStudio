note
	description	: "Names for buttons, labels, ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	INTERFACE_NAMES

inherit
	WIZARD_SHARED

feature -- Labels names

	l_Library_name: STRING_GENERAL			do Result := locale.translation ("Library Name") end
	l_Done: STRING_GENERAL					do Result := locale.translation ("Done") end
	l_Compilable_libraries: STRING_GENERAL	do Result := locale.translation ("Available libraries:") end
	l_Libraries_to_compile: STRING_GENERAL	do Result := locale.translation ("Libraries to precompile:") end
	l_Yes: STRING_GENERAL 					do Result := locale.translation ("Yes") end
	l_No: STRING_GENERAL 					do Result := locale.translation ("No") end
	l_bye: STRING_GENERAL					do Result := locale.translation ("Bye") end
	l_total_progress: STRING_GENERAL			do Result := locale.translation ("Total Progress: ") end
	l_preparing_precompilation: STRING_GENERAL	do Result := locale.translation ("Preparing precompilations ...") end
	l_eiffel_conf_file: STRING_GENERAL 		do Result := locale.translation ("Eiffel Configuration Files (*.ecf)") end

	l_precompiling_library (a_lib: STRING_GENERAL): STRING_GENERAL
		require
			a_lib_not_void: a_lib /= Void
		do
			Result := locale.formatted_string (locale.translation ("Precompiling $1 library: "), [a_lib])
		end

	l_total_progress_is (a_str: STRING_GENERAL): STRING_GENERAL
		require
			a_str_not_void: a_str /= Void
		do
			Result := locale.formatted_string (locale.translation ("Total progress: $1%%"), [a_str])
		end

feature -- Buttons names

	b_Add_all: STRING_GENERAL				do Result := locale.translation ("Add all ->") end
	b_Add: STRING_GENERAL 					do Result := locale.translation ("Add ->") end
	b_Remove_all: STRING_GENERAL				do Result := locale.translation ("<- Remove all") end
	b_Remove: STRING_GENERAL					do Result := locale.translation ("<- Remove") end
	b_Add_your_own_library: STRING_GENERAL	do Result := locale.translation ("Add your own library...") end

feature -- Title

	t_wizard_error: STRING_GENERAL 			do Result := locale.translation ("Precompilation Wizard Error") end
	t_variables_error: STRING_GENERAL 		do Result := locale.translation ("Environment variables Error") end
	t_launch_precompilations: STRING_GENERAL do Result := locale.translation ("Launch Precompilations") end
	t_choose_libraries: STRING_GENERAL		do Result := locale.translation ("Choose Libraries to precompile") end
	t_choose_libraries_subtitle: STRING_GENERAL		do Result := locale.translation ("Choose the libraries you want to precompile.%NYou can even add your own library.") end
	t_precompilation_wizard: STRING_GENERAL		do Result := locale.translation ("Precompilation Wizard") end
	t_welcome_to_the_wizard: STRING_GENERAL	do Result := locale.translation ("Welcome to the%NPrecompilation Wizard") end

feature -- Message

	m_you_must_choose_library: STRING_GENERAL
				do Result := locale.translation ("You must choose at least one library.%N%
				%%N%
				%If you want to precompile one or more libraries, click Back%N%
				%and add the libraries you want to precompile into the right list%N%
				%%N%
				%If you don't want to precompile any library, click Cancel") end

	m_following_evironment_variables_not_set: STRING_GENERAL
				do Result := locale.translation ("The following environment variables are not set:%N") end

	m_fix_and_restart: STRING_GENERAL
				do Result := locale.translation ("Fix the problem and restart the wizard.") end

	m_precompilation_will_be_launch: STRING_GENERAL
				do Result := locale.translation ("The precompilation(s) will be launched as soon%N%
				%as you push the Finish button%N%
				%%N%
				%Be patient, this can take a while!") end

	m_precompilation_done: STRING_GENERAL
				do Result := locale.translation ("Precompilations done !") end

	m_internal_error_ocurred: STRING_GENERAL
				do Result := locale.translation ("An internal error has occurred.%N%
				%The wizard will terminate.%N") end

	m_configuration_file_is_already_listed: STRING_GENERAL
				do Result := locale.translation ("The configuration file you have selected is already listed.") end

	m_configuration_file_is_not_valid: STRING_GENERAL
				do Result := locale.translation ("The configuration file you have selected is not valid.") end

	m_wizard_introduction: STRING_GENERAL
				do Result := locale.translation ("[
				Using this wizard you can precompile any
				Eiffel library. You will be able to precompile
				the shipped libraries but also your own
				libraries by providing the corresponding
				configuration file.
				
				If you precompile a library already precompiled,
				the previous version will be overwritten
				
				
				To continue, click Next.
				]") end


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

end -- class INTERFACE_NAMES
