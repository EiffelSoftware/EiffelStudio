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
		do
			location:= "d:\tmp3"
			compile_project:= False
			icon_location:= wizard_resources_path + "\eiffel.ico"
			project_name:= "My_new_project"
			dialog_application:= False
			rc_location:= ""
			full_path_rc:= ""
			dialog_with_no_rc:= False
		end

feature -- Setting

	set_full_path_rc (s: STRING) is
		do
			full_path_rc:= s
		end

	set_rc_location (s: STRING) is
		do
			rc_location:= s
		end

	set_dialog_application (b: BOOLEAN) is
		do
			dialog_application:= b
		end

	set_location (s: STRING) is
		do
			location:= s
		end

	set_icon_location (s: STRING) is
		do
			icon_location:= s
		end

	set_project_name (s: STRING) is
		do
			project_name:= s
		end

	set_compile_project (b: BOOLEAN) is
		do
			compile_project:= b
		end

	set_root_dialog_name (s: STRING) is
		do
			root_dialog_name:= s
		end

	set_dialog_with_no_rc (b: BOOLEAN) is
		do
			dialog_with_no_rc:= b
		end

feature -- Access


	root_dialog_name: STRING
		-- Name of the root dialog name

	icon_location: STRING
		-- Location of the icon choose by the user
	
	location: STRING
		-- Location of the generated code

	project_name: STRING
		-- Name of the project

	rc_location: STRING
		-- Location of the rc file

	full_path_rc: STRING
		-- The path of the rc file

	dialog_with_no_rc: BOOLEAN
		-- Does the user has selected to generate a dialog with no rc file

	compile_project: BOOLEAN
		-- Does the user want to compile the project at the end of the generation

	dialog_application: BOOLEAN
		-- Does the user want to generate a dialog application

end -- class WIZARD_INFORMATION
