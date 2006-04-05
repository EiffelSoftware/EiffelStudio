indexing
	description	: "Names for buttons, labels, ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	INTERFACE_NAMES

feature -- Labels names

	l_Available_assemblies_name: STRING is 	"Available assemblies Name" 
	l_Creation_routine_name: STRING is 	"Creation routine name"
	l_Creation_routine_external_name: STRING is 	"Creation routine .NET name"
	l_Culture: STRING is				"Culture"
	l_Dotnet_assembly: STRING is 		".NET Assembly"
	l_Eiffel_formatting: STRING is 		"Generate Eiffel-friendly names"
	l_Emit_directory: STRING is 			"Import Directory"
	l_Public_key: STRING is 			"Public Key"
	l_Root_class_name: STRING is 		"Root class name"
	l_Root_class_external_name: STRING is 	"Root class .NET name"
	l_Selected_assemblies_name: STRING is	"Selected assemblies Name"
	l_Version: STRING is 				"Version"
	l_clr_version: STRING is			"Targeted CLR Version:"
	l_clr_most_recent_version: STRING is 	"Use most recent CLR Version:"
	l_clr_most_recent_version_summary: STRING is 	"Most recent CLR Version"
	l_none_class: STRING is "none"

feature -- Buttons names

	b_Abort: STRING is 				"Abort"
	b_Add: STRING is					"Add ->"
	--b_Assembly_manager: STRING is 		"ISE Assembly Manager"
	b_Close: STRING is 				"Close"
	b_Ignore: STRING is				"Ignore"
	b_Import_local_assemblies: STRING is	"Browse..."
	b_Remove: STRING is				"<- Remove"
	b_Retry: STRING is 				"Retry"

feature -- Messages

	m_Creation_routine_name_error: STRING is
								"The creation routine name that you have specified does not conform%N%
								%the lace specification.%N%
								%%N%
								%A valid creation routine name is not empty and only contains letters,%N%
								%digits, and underscores. The first character must%N%
								%be a letter.%N%
								%%N%
								%Click Back and choose a valid creation routine name."

	m_Wizard_instalation_error: STRING is
								"The wizard can not be completed because its installation is not complete.%N%
								%The COM component %"ISE.VS.VisionSupport%" is missing or not registered.%N%
								%%N%
								%Contact htpp://support.eiffel.com for more details.%N%
								%%N%
								%Click Abort to finish the wizard."

	m_Empty_root_class_external_name_error: STRING is
								"Please chose a .NET name for the root class.%N%
								%The .NET name is the name that will be used%N%
								%by other .NET components when calling this class."

	m_Empty_creation_routine_external_name_error: STRING is
								"Please chose a .NET name for the creation routine.%N%
								%The .NET name is the name that will be used%N%
								%by other .NET components when calling this routine."

	m_Filename_error: STRING is 
						"The .NET Assembly filename that you have chosen is not valid.%N%
						%%N%
						%Please click Back and choose another filename."

	m_Final_title: STRING is "Completing the New .NET%NApplication Wizard"

	m_Invalid_data_error: STRING is
							"Either the root class name or the creation routine name (or both of them) that you have specified%N%
							%does not conform the lace specification.%N%
							%%N%
							%A valid Eiffel name is not empty and only contains letters,%N%
							%digits, and underscores. The first character must%N%
							%be a letter.%N%
							%%N%
							%Click Back and choose valid Eiffel names."

	m_Root_class_name_error: STRING is
							"The root class name that you have specified does not conform%N%
							%the lace specification.%N%
							%%N%
							%A valid root class name is not empty and only contains letters,%N%
							%digits, and underscores. The first character must%N%
							%be a letter.%N%
							%%N%
							%Click Back and choose a valid root class name."

	m_Second_state: STRING is "You can create an executable file (.exe) or  dynamic-link library (.dll)"

	m_Welcome_message: STRING is 
							"Using this wizard you can create a project (executable%N%
							%or dynamic library) targeting the Microsoft .NET platform.%N%
							%%N%
							%The generated application will run on any system%N%
							%where the .NET runtime is installed.%N%
							%%N%
							%%N%
							%%N%
							%To continue, click Next."

	m_Welcome_title: STRING is "Welcome to the%Nnew .NET Application Wizard"

feature -- Titles

	t_Creation_routine_name_error: STRING is "Creation Routine Name Error"
	t_Wizard_instalation_error: STRING is "Wizard instalation Error"
	t_Empty_creation_routine_external_name_error: STRING is "Empty Creation Routine .NET Name Error"
	t_Empty_root_class_external_name_error: STRING is "Empty Root Class .NET Name Error"
	t_Filename_error: STRING is ".NET Assembly Filename Error"
	t_Invalid_data_error: STRING is "Invalid Names Error"
	t_Root_class_name_error: STRING is "Root Class Name Error"
	t_Second_state: STRING is ".NET Application type and Project settings"
	t_Third_state: STRING is "Assembly selection"
	t_Wizard_title: STRING is "New .NET Application Wizard";

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
