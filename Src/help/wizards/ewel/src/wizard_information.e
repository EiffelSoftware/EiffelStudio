indexing
	description	: "All information about the wizard ... This class is inherited in each state "
	author		: "davids"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_INFORMATION

inherit
	BENCH_WIZARD_INFORMATION
		redefine
			make
		end

creation
	make

feature  -- Initialization

	make is
			-- Assign default values
		local
			icon_path: FILE_NAME
		do
			Precursor

			create icon_path.make_from_string (wizard_resources_path)
			icon_path.set_file_name ("eiffel")
			icon_path.add_extension ("ico")
			set_icon_location (icon_path)

			set_dialog_application (False)
		end

feature -- Setting

	set_dialog_application (b: BOOLEAN) is
		do
			dialog_application := b
		end

	set_icon_location (s: STRING) is
		do
			icon_location := s
		end

feature -- Access

	icon_location: STRING
			-- Location of the icon choose by the user
	
	dialog_application: BOOLEAN
			-- Does the user want to generate a dialog application

feature {NONE} -- Implementation

	Default_project_name: STRING is
			-- Default project name
		do
			Result := "my_wel_application"
		end

end -- class WIZARD_INFORMATION
