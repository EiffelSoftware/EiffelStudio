indexing
	description: "Constants used to save settings"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SETTINGS_CONSTANTS

feature -- Access

	Project_type_key: STRING is "Project_type_key"
			-- Project type key used to store project type settings
	
	Component_type_key: STRING is "Component_type_key"
			-- Component type key used to store component type settings

	Compile_target_key: STRING is "Compile_target_key"
			-- Compile target key used to store compile target settings
	
	Backup_key: STRING is "Backup_key"
			-- Key to store whether EiffelCOM wizard should backup overwritten files

	Overwrite_key: STRING is "Overwrite_key"
			-- Key to store whether EiffelCOM wizard should overwrite generated files

	Marshaller_key: STRING is "Marshaller_key"
			-- Key to store whether EiffelCOM wizard should generate and use marshaller

	Eiffel_project_code: STRING is "Eiffel"
			-- String encoding for Eiffel project
	
	Server_project_code: STRING is "Server"
			-- String encoding for COM Server project
	
	Client_project_code: STRING is "Client"
			-- String encoding for COM client project

	In_process_code: STRING is "InProcess"
			-- String encoding for in-process component

	Out_of_process_code: STRING is "OutOfProc"
			-- String encoding for out-of-process component

	Both_compile_code: STRING is "Both"
			-- String encoding for not compiling C nor Eiffel code

	Eiffel_compile_code: STRING is "Eiffel"
			-- String encoding for not compiling Eiffel code

	None_code: STRING is "None"
			-- String encoding for compiling C and Eiffel code

	True_code: STRING is "True"
			-- String encoding for backuping overwritten files

end -- class WIZARD_SETTINGS_CONSTANTS
