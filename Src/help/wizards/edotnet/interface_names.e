indexing
	description	: "Names for buttons, labels, ..."

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
	
feature -- Buttons names

	b_Abort: STRING is 				"Abort"
	b_Add: STRING is					"Add ->"
	b_Assembly_manager: STRING is 		"ISE Assembly Manager"
	b_Close: STRING is 				"Close"
	b_Ignore: STRING is				"Ignore"
	b_Import_local_assemblies: STRING is	"Import Local Assemblies"
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
	t_Empty_creation_routine_external_name_error: STRING is "Empty Creation Routine .NET Name Error"
	t_Empty_root_class_external_name_error: STRING is "Empty Root Class .NET Name Error"
	t_Filename_error: STRING is ".NET Assembly Filename Error"
	t_Invalid_data_error: STRING is "Invalid Names Error"
	t_Root_class_name_error: STRING is "Root Class Name Error"
	t_Second_state: STRING is ".NET Application type and Project settings"
	t_Third_state: STRING is "Assembly selection"
	t_Wizard_title: STRING is "New .NET Application Wizard"

end -- class INTERFACE_NAMES
