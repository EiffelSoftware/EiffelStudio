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
		do
			Precursor
			icon_location := clone (wizard_resources_path)
			icon_location.extend ("eiffel.ico")
			dialog_application := False
			has_status_bar := False
			has_tool_bar := False
			has_menu_bar := True
			has_about_dialog := True
		end

feature -- Setting

	set_has_status_bar (b: BOOLEAN) is
			-- Set `has_status_bar' to `b'.
		do
			has_status_bar := b
		end

	set_has_menu_bar (b: BOOLEAN) is
			-- Set `has_menu_bar' to `b'.
		do
			has_menu_bar := b
		end

	set_has_tool_bar (b: BOOLEAN) is
			-- Set `has_tool_bar' to `b'.
		do
			has_tool_bar := b
		end

	set_has_about_dialog (b: BOOLEAN) is
			-- Set `has_about_dialog' to `b'.
		do
			has_about_dialog := b
		end

	set_icon_location (s: STRING) is
		do
			create icon_location.make_from_string (s)
		end

	set_dialog_application (b: BOOLEAN) is
		do
			dialog_application := b
		end

feature -- Access

	has_status_bar: BOOLEAN
			-- Does the generated application include a status bar?

	has_menu_bar: BOOLEAN
			-- Does the generated application include a menu bar?

	has_tool_bar: BOOLEAN
			-- Does the generated application include a tool bar?

	has_about_dialog: BOOLEAN
			-- Does the generated application include an "About" dialog box?

	icon_location: FILE_NAME
			-- Location of the icon choose by the user
	
	dialog_application: BOOLEAN
			-- Does the user want to generate a dialog application
			
feature {NONE} -- Implementation

	Default_project_name: STRING is
			-- Default project name
		do
			Result := "my_vision2_application"
		end

end -- class WIZARD_INFORMATION
