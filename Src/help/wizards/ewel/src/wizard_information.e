indexing
	description: "All information about the wizard ... This class is inherited in each state "
	author: "davids"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_INFORMATION

inherit
	WIZARD_SHARED

Creation
	make

feature  -- Initialization

	make is
			-- Assign default values
		do
			location := "C:\MyProjects\"
			compile_project := True
			icon_location := wizard_resources_path + "\eiffel.ico"
			project_name := "my_wel_project"
			dialog_application := False
			ace_location := ""
		end

feature -- Setting

	set_dialog_application (b: BOOLEAN) is
		do
			dialog_application := b
		end

	set_location (s: STRING) is
		do
			location := s
		end

	set_icon_location (s: STRING) is
		do
			icon_location := s
		end

	set_project_name (s: STRING) is
		do
			project_name := s
		end

	set_compile_project (b: BOOLEAN) is
		do
			compile_project := b
		end

	set_root_dialog_name (s: STRING) is
		do
			root_dialog_name := s
		end

	set_ace_location (s: STRING) is
		do
			ace_location := s
		end

feature -- Access

	root_dialog_name: STRING
			-- Name of the root dialog name

	icon_location: STRING
			-- Location of the icon choose by the user
	
	location: STRING
			-- Location of the generated code

	ace_location: STRING
			-- Location of the ace file

	project_name: STRING
			-- Name of the project

	compile_project: BOOLEAN
			-- Does the user want to compile the project at the end of the generation

	dialog_application: BOOLEAN
			-- Does the user want to generate a dialog application

end -- class WIZARD_INFORMATION
