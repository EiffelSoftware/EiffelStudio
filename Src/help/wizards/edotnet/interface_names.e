indexing
	description	: "Names for buttons, labels, ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	INTERFACE_NAMES

inherit
	WIZARD_SHARED

feature -- Labels names

	l_Available_assemblies_name: STRING_GENERAL is 	do Result := locale.translate ("Available assemblies Name") end
	l_application_type: STRING_GENERAL is do Result := locale.translate ("Application type") end
	l_Creation_routine_name: STRING_GENERAL is 	do Result := locale.translate ("Creation routine name") end
	l_Creation_routine_external_name: STRING_GENERAL is 	do Result := locale.translate ("Creation routine .NET name") end
	l_Culture: STRING_GENERAL is				do Result := locale.translate ("Culture") end
	l_Dotnet_assembly: STRING_GENERAL is 		do Result := locale.translate (".NET Assembly") end
	l_Eiffel_formatting: STRING_GENERAL is 		do Result := locale.translate ("Generate Eiffel-friendly names") end
	l_Emit_directory: STRING_GENERAL is 			do Result := locale.translate ("Import Directory") end
	l_Public_key: STRING_GENERAL is 			do Result := locale.translate ("Public Key") end
	l_Root_class_name: STRING_GENERAL is 		do Result := locale.translate ("Root class name") end
	l_Root_class_external_name: STRING_GENERAL is 	do Result := locale.translate ("Root class .NET name") end
	l_Selected_assemblies_name: STRING_GENERAL is	do Result := locale.translate ("Selected assemblies Name") end
	l_Version: STRING_GENERAL is 				do Result := locale.translate ("Version") end
	l_clr_version: STRING_GENERAL is			do Result := locale.translate ("Targeted CLR Version:") end
	l_clr_most_recent_version: STRING_GENERAL is 	do Result := locale.translate ("Use most recent CLR Version:") end
	l_clr_most_recent_version_summary: STRING_GENERAL is 	do Result := locale.translate ("Most recent CLR Version") end
	l_you_have_specified_following_settings: STRING_GENERAL is do Result := locale.translate ("You have specified the following settings:") end
	l_Exe_type: STRING_GENERAL is do Result := locale.translate ("Executable") end
			-- Meaning of EXE

	l_Dll_type: STRING_GENERAL is do Result := locale.translate ("Dynamic-Link Library") end
			-- Meaning of DLL

	l_second_subtitle_text: STRING_GENERAL is do Result := locale.translate ("You can choose to create a .exe or a .dll file%N%
					%and select the names of the root class and its creation routine.") end

	l_Console_application: STRING_GENERAL is do Result := locale.translate ("Console application") end
			-- Text associated to `console_app_b'.

	l_yes: STRING_GENERAL is do Result := locale.translate ("Yes") end
	l_no: STRING_GENERAL is do Result := locale.translate ("No") end
	l_none_class: STRING is "none"

feature -- Buttons names

	b_Add: STRING_GENERAL is					do Result := locale.translate ("Add ->") end
	--b_Assembly_manager: STRING_GENERAL is 		do Result := locale.translate ("ISE Assembly Manager") end
	b_Close: STRING_GENERAL is 				do Result := locale.translate ("Close") end
	b_Ignore: STRING_GENERAL is				do Result := locale.translate ("Ignore") end
	b_Import_local_assemblies: STRING_GENERAL is	do Result := locale.translate ("Browse...") end
	b_Remove: STRING_GENERAL is				do Result := locale.translate ("<- Remove") end
	b_Retry: STRING_GENERAL is 				do Result := locale.translate ("Retry") end

feature -- Messages

	m_Creation_routine_name_error: STRING_GENERAL is
								do Result := locale.translate ("The creation routine name that you have specified does not conform%N%
								%the lace specification.%N%
								%%N%
								%A valid creation routine name is not empty and only contains letters,%N%
								%digits, and underscores. The first character must%N%
								%be a letter.%N%
								%%N%
								%Click Back and choose a valid creation routine name.") end

	m_Wizard_instalation_error: STRING_GENERAL is
								do Result := locale.translate ("The wizard can not be completed because its installation is not complete.%N%
								%The COM component %"ISE.VS.VisionSupport%" is missing or not registered.%N%
								%%N%
								%Contact http://support.eiffel.com for more details.%N%
								%%N%
								%Click Abort to finish the wizard.") end

	m_Empty_root_class_external_name_error: STRING_GENERAL is
								do Result := locale.translate ("Please chose a .NET name for the root class.%N%
								%The .NET name is the name that will be used%N%
								%by other .NET components when calling this class.") end

	m_Empty_creation_routine_external_name_error: STRING_GENERAL is
								do Result := locale.translate ("Please chose a .NET name for the creation routine.%N%
								%The .NET name is the name that will be used%N%
								%by other .NET components when calling this routine.") end

	m_Filename_error: STRING_GENERAL is
						do Result := locale.translate ("The .NET Assembly filename that you have chosen is not valid.%N%
						%%N%
						%Please click Back and choose another filename.") end

	m_Final_title: STRING_GENERAL is do Result := locale.translate ("Completing the New .NET%NApplication Wizard") end

	m_Invalid_data_error: STRING_GENERAL is
							do Result := locale.translate ("Either the root class name or the creation routine name (or both of them) that you have specified%N%
							%does not conform the lace specification.%N%
							%%N%
							%A valid Eiffel name is not empty and only contains letters,%N%
							%digits, and underscores. The first character must%N%
							%be a letter.%N%
							%%N%
							%Click Back and choose valid Eiffel names.") end

	m_Root_class_name_error: STRING_GENERAL is
							do Result := locale.translate ("The root class name that you have specified does not conform%N%
							%the lace specification.%N%
							%%N%
							%A valid root class name is not empty and only contains letters,%N%
							%digits, and underscores. The first character must%N%
							%be a letter.%N%
							%%N%
							%Click Back and choose a valid root class name.") end

	m_Second_state: STRING_GENERAL is do Result := locale.translate ("You can create an executable file (.exe) or  dynamic-link library (.dll)") end

	m_Welcome_message: STRING_GENERAL is
							do Result := locale.translate ("Using this wizard you can create a project (executable%N%
							%or dynamic library) targeting the Microsoft .NET platform.%N%
							%%N%
							%The generated application will run on any system%N%
							%where the .NET runtime is installed.%N%
							%%N%
							%%N%
							%%N%
							%To continue, click Next.") end

	m_Welcome_title: STRING_GENERAL is do Result := locale.translate ("Welcome to the%Nnew .NET Application Wizard") end

	m_final_state_message (a_compile: BOOLEAN): STRING_GENERAL is
			-- Final state message according to `a_word'
		do
			if a_compile then
				Result := locale.translate ("Click Finish to generate and compile this project.")
			else
				Result := locale.translate ("Click Finish to generate this project.")
			end
		ensure
			non_void_message: Result /= Void
			not_empty_message: not Result.is_empty
		end

feature -- Titles

	t_Creation_routine_name_error: STRING_GENERAL is do Result := locale.translate ("Creation Routine Name Error") end
	t_Wizard_instalation_error: STRING_GENERAL is do Result := locale.translate ("Wizard instalation Error") end
	t_Empty_creation_routine_external_name_error: STRING_GENERAL is do Result := locale.translate ("Empty Creation Routine .NET Name Error") end
	t_Empty_root_class_external_name_error: STRING_GENERAL is do Result := locale.translate ("Empty Root Class .NET Name Error") end
	t_Filename_error: STRING_GENERAL is do Result := locale.translate (".NET Assembly Filename Error") end
	t_Invalid_data_error: STRING_GENERAL is do Result := locale.translate ("Invalid Names Error") end
	t_Root_class_name_error: STRING_GENERAL is do Result := locale.translate ("Root Class Name Error") end
	t_Second_state: STRING_GENERAL is do Result := locale.translate (".NET Application type and Project settings") end
	t_Third_state: STRING_GENERAL is do Result := locale.translate ("Assembly selection") end
	t_Wizard_title: STRING_GENERAL is do Result := locale.translate ("New .NET Application Wizard") end;

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
end -- class INTERFACE_NAMES
