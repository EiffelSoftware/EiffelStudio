indexing
	description: "Objects that provide access to constants used."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_CONSTANTS
	
inherit
	ANY	
		undefine
			default_create, copy, is_equal
		end

feature -- Access
		
	Gb_display_window_title: STRING is "Display window"
		-- Title to be displayed in GB_DISPLAY_WINDOW.
		
	Gb_builder_window_title: STRING is "Builder window"
		-- Title to be displayed in GB_BUILDER_WINDOW.
		
	Gb_object_editor_window_title: STRING is "Object editor"
		-- Title to be displayed in GB_OBJECT_EDITOR.

	Product_name: STRING is "EiffelBuild"
		-- Name of system displayed to users.
	
feature -- Menu texts.
	
	Gb_file_menu_text: STRING is "&File"
		-- Text of file menu.
		
	Gb_file_exit_menu_text: STRING is "&Exit"
		
	Gb_help_about_menu_text: STRING is "&About..."
	
	Gb_help_menu_text: STRING is "&Help"
	
	Gb_project_menu_text: STRING is "Project"
	
	Gb_project_menu_build_text: STRING is "Build"

	Gb_project_menu_settings_text: STRING is "&Settings"
	
	Gb_view_menu_text: STRING is "&View"
	
feature -- String representations of class names.

	Gb_primitive_object_class_name: STRING is "GB_PRIMITIVE_OBJECT"
	
	Gb_cell_object_class_name: STRING is "GB_CELL_OBJECT"
	
	Gb_container_object_class_name: STRING is "GB_CONTAINER_OBJECT"
	
	Ev_window_string: STRING is "EV_WINDOW"
	
	Ev_titled_window_string: STRING is "EV_TITLED_WINDOW"

feature -- Miscellaneous

	Internal_properties_string: STRING is "Internal_properties"
		-- Xml tag used to store properties stored by GB_OBJECT
		-- but not in the interface of Vision2.
	
feature -- Directories

	gb_ev_directory: FILE_NAME is
		do
			create Result.make_from_string ((create {EIFFEL_ENV}).Eiffel_installation_dir_name)
			Result.extend ("build")
			Result.extend ("interface")
		end
	
feature -- Default values

	Minimum_width_of_object_editor: INTEGER is 165
		-- The minimum width allowed for a GB_OBJECT_EDITOR
		
	Default_floating_object_editor_height: INTEGER is 500
		-- The default height of a newly created floating object editor window.
		
	Default_width_of_type_selector: INTEGER is 180
		-- The default width of the type selector.
		
	Default_height_of_type_selector: INTEGER is 250
		-- The default_height of the type selector.

feature -- Generation constants

	template_file_location: FILE_NAME is
			-- Location of templates.
		do
			create Result.make_from_string ((create {EIFFEL_ENV}).Eiffel_installation_dir_name)		
			Result.extend ("build")
			Result.extend ("templates")
		end
		

	window_template_file_name: FILE_NAME is
			-- `Result' is location of build template file,
			-- including the name.
		do
			Result := template_file_location
			Result.extend ("build_class_template.e")
		end
		
	application_template_file_name: FILE_NAME is
			-- `Result' is location of build application template file,
			-- including the name.
		do
			Result := template_file_location
			Result.extend ("build_application_template.e")
		end
		
	windows_ace_file_name: FILE_NAME is
			-- `Result' is location of windows ace file template.
		do
			Result := template_file_location
			Result.extend ("windows")
			Result.extend ("ace_template.ace")
		end
		
	unix_ace_file_name: FILE_NAME is
			-- `Result' is location of windows ace file template.
		do
			Result := template_file_location
			Result.extend ("unix")
			Result.extend ("ace_template.ace")
		end
		
	class_name_tag: STRING is
			-- `Result' is tag used in templates
			-- for the class name.
		once
			Result := "<CLASS_NAME>"
		end
		
	create_tag: STRING is
			-- `Result' is tag used in templates
			-- for the creation of widgets.
		once
			Result := "<CREATE>"
		end
		
	build_tag: STRING is
			-- `Result' is tag used in templates
			-- for buiilding of the widget heirarchy.
		once
			Result := "<BUILD>"
		end
		
	set_tag: STRING is
			-- `Result' is tag used in templates
			-- for the setting of widgets properties.
		once
			Result := "<SET>"
		end
		
	local_tag: STRING is
			-- `Result' is tag used in templates
			-- for local definitions.
		once
			Result := "<LOCAL>"
		end
		
	main_window_tag: STRING is
			-- `Result' is tag used in templates
			-- for the main window declaration.
		once
			Result := "<MAIN_WINDOW>"
		end
		
	project_location_tag: STRING is
			-- `Result' is tag used in ace templates
			-- for the project location.
		once
			Result := "<PROJECT_LOCATION>"
		end
		
		
		
	indent: STRING is
			-- String representing standard indent
			-- for code generation.
		once
			Result := "%R%N%T%T%T"
		end
		
	Local_object_name_prepend_string: STRING is "l_"
			-- generated local variables are of the form
			-- `Result' + short type + number.
			-- i.e. l_button1
			
	Generation_directory: STRING is "generated"
		-- Directory name to hold the generated files.
		
	pixmap_name: STRING is "internal_pixmap"
		-- Name of temporary pixmap used during generation
		-- of pixmap setting code.
		
		
feature -- XML saving

	filename: FILE_NAME is
			-- File to be generated.
		local
			accessible_status: GB_SHARED_SYSTEM_STATUS
		do
			create accessible_status
			create Result.make_from_string (accessible_status.system_status.current_project_settings.project_location)
			Result.extend ("system_interface.xml")
		end		
		
	component_filename: FILE_NAME is
			-- Location of component file.
		do
			create Result.make_from_string ((create {EIFFEL_ENV}).Eiffel_installation_dir_name)
			Result.extend ("build")
			Result.extend ("components")
			Result.extend ("components.xml")
		end
		
	project_filename: STRING is "build_project.bpr"
		-- File name for project settings.
		
	project_file_filter: STRING is "*.bpr"
		-- Filter to be used for file dialogs searching
		-- for build projects.
		
	xml_format: STRING is "<?xml version=%"1.0%" encoding=%"UTF-8%"?>"
		-- XML format type, included at start of `document'.
		
	type_string: UCSTRING is
			-- String used to match type within XML.
		once
			create Result.make_from_string ("type")
		end
		
feature -- XML constants


	True_string: STRING is "True"
		-- String constant representing True.
		
	False_string: STRING is "False"
		-- String constant representing False.
		
	Item_string: STRING is "item"
		-- String constant representing "item".
		
	Name_string: STRING is "name"
		-- String constant representing "name".
	
	Schema_instance: STRING is "http://www.w3.org/1999/XMLSchema-instance"
		-- Schema information for inclusion in XML files.
	
feature -- Dialogs

	b_OK: STRING is "OK"
	
	b_Cancel: STRING is "Cancel"
	
	b_Apply: STRING is "Apply"

	Save_prompt: STRING is "Do you wish to save the current project?"
	
feature -- Warning Dialogs

	Exit_warning: STRING is "Are you sure you wish to Exit?"
		-- Displayed in a dialog when user attempts to quit.
	
	Exit_save_warning: STRING is "The project has not been saved.%NDo you wish to save it before exiting?"
		-- Dispalyed in a dialog when user attempts to quit with an unsave project.

	Object_editor_button_warning: STRING is "Please drop an object on this button%NUse right click for both%Npick and drop actions."
	
	Project_exists_warning: STRING is "A Build project already exists in the selected directory. Do you wish to overwrite this project?"

	Invalid_project_warning: STRING is "Invalid build project file. Please select a different file."
		-- Warning displayed when a user attempts to open an invalid build project.

	Duplicate_name_warning_part1: STRING is "An object exists with the name '"
		-- First part of warning used when a name that already exists is entered.
		
	Duplicate_name_warning_part2: STRING is "'. Object names must be unique.%N%NSelecting 'Modify' will allow editing of current invalid name%NSelecting 'Cancel' will restore old name."
		-- Second part of warning used when a name that already exists is entered.

	Delete_component_warning: STRING is "Are you sure you wish to delete the component from the system?"

	Class_invalid_name_warning: STRING is " is not a valid Class name.%NClass names should only include%N%
		%alphanumeric characters or underscores,%Nand start with an alphabetic character.%N%
		%please select a different Class name."

	Component_invalid_name_warning: STRING is " is not a valid Component name.%NComponent names should only include%N%
		%alphanumeric characters or underscores,%Nand start with an alphabetic character.%N%
		%please select a different component name."
		
	Component_identical_name_warning: STRING is " is already used as a component name.%NPlease enter a unique component name."

end -- class GB_CONSTANTS
