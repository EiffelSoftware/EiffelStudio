indexing
	description: "All information about the wizard ... This class is inherited in each state "
	author: "davids"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_INFORMATION

Creation
	make

feature  -- Initialization
	make is
		do
			location:= "d:\tmp4"
			compile_project:= False
			icon_location:= ""
			project_name:= "My_new_project"
			dialog_application:= False
			rc_location:= ""
			full_path_rc:= ""
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

feature -- Access

	root_dialog_name: STRING

	compile_project: BOOLEAN

	icon_location: STRING
	
	location: STRING

	project_name: STRING

	dialog_application: BOOLEAN

	rc_location: STRING

	full_path_rc: STRING

end -- class WIZARD_INFORMATION
