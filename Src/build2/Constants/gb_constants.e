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
		
	Visual_studio_project_argument: STRING is "visualstudio_project"
		-- Command line argument to start from VisualStudio.
	
	Class_argument: STRING is "class"
		-- Command line argument to start as class only.
		
	Wizard_title: STRING is "Eiffel Build Wizard"
		-- title displayed in wizard mode.
	
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
	
	Ev_menu_bar_string: STRING is "EV_MENU_BAR"
	
	Ev_widget_string: STRING is "EV_WIDGET"
	
	Ev_cell_string: STRING is "EV_CELL"
	
	Ev_primitive_string: STRING is "EV_PRIMITIVE"
	
	Ev_tool_bar_string: STRING is "EV_TOOL_BAR"
	
	Ev_menu_string: STRING is "EV_MENU"
	
	Ev_menu_item_string: STRING is "EV_MENU_ITEM"
	
	Ev_tree_item_string: STRING is "EV_TREE_ITEM"
	
	Ev_container_string: STRING is "EV_CONTAINER"
	
	Ev_widget_list_string: STRING is "EV_WIDGET_LIST"
	
	Ev_table_string: STRING is "EV_TABLE"
	
	Ev_split_area_string: STRING is "EV_SPLIT_AREA"
	
	Ev_list_string: STRING is "EV_LIST"
	
	Ev_combo_box_string: STRING is "EV_COMBO_BOX"
	
	Ev_tree_string: STRING is "EV_TREE"
	
	Ev_item_string: STRING is "EV_ITEM"
	
	Ev_tool_bar_item_string: STRING is "EV_TOOL_BAR_ITEM"
	
	Ev_list_item_string: STRING is "EV_LIST_ITEM"
	
	Ev_spin_button_string: STRING is "EV_SPIN_BUTTON"
	
feature -- GB_EV_FIXED

	select_widget_prompt: STRING is "Please select desired widget."
	
	resize_widget_prompt: STRING is "Highlighted widget is positionable"
	
	widget_size_prompt: STRING is "Widget is 0x0 pixels, click HERE to enlarge."

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
		
	window_template_imp_file_name: FILE_NAME is
			-- `Result' is location of build template file,
			-- including the name.
		do
			Result := template_file_location
			Result.extend ("build_class_template_imp.e")
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
		
	eiffel_class_extension: STRING is ".e"
			-- String constant for class file extension to be used.
		
	class_name_tag: STRING is
			-- `Result' is tag used in templates
			-- for the class name.
		once
			Result := "<CLASS_NAME>"
		end
		
	inherited_class_name_tag: STRING is
			-- `Result' is tag used in templates
			-- for the inherited class name.
		once
			Result := "<INHERITED_CLASS_NAME>"
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
		
	event_connection_tag: STRING is
			-- `Result' is tag used in templates
			-- for the event connection declarations.
		once
			Result := "<EVENT_CONNECTION>"
		end
		
	event_declaration_tag: STRING is
			-- `Result' is tag used in templates
			-- for the event declarations.
		once
			Result := "<EVENT_DECLARATION>"
		end
		
	attribute_tag: STRING is
			-- `Result' is tag used in templates
			-- for the attribute declarations.
		once
			Result := "<ATTRIBUTE>"
		end
		
	application_tag: STRING is
			-- `Result' is tag used in templates for
			-- the application declaration.
		once
			Result := "<APPLICATION>"
		end
		
	project_name_tag: STRING is
			--
		once
			Result := "<PROJECT_NAME>"
		end
		
		
	
		
	indent: STRING is
			-- String representing standard indent
			-- for code generation.
		once
			Result := indent_less_one + "%T"
		end
		
	indent_less_one: STRING is
			-- String representing an indent one
			-- tabs less than `indent'.
		once
			Result := indent_less_two + "%T"
		end
		
	indent_less_two: STRING is
			-- String representing an indent two
			-- tabs less than `indent'.
		once
			Result := "%R%N%T"
		end

	Local_object_name_prepend_string: STRING is "l_"
			-- generated local variables are of the form
			-- `Result' + short type + number.
			-- i.e. l_button1

	pixmap_name: STRING is "internal_pixmap"
		-- Name of temporary pixmap used during generation
		-- of pixmap setting code.

	class_implementation_extension: STRING is "_IMP"
		-- Extension to be added to generated class name,
		-- for the implementation class.
		
	connect_events_comment: STRING is 
			-- Comment to be inserted into generated code before
			-- the event connections are declared.
		once
			Result := indent + "%T--Connect events."
		end
		
	build_widgets_comment: STRING is
			-- Comment to be inserted into generated code before
			-- the widgets are parented.
		once
			Result := indent + "%T-- Build_widget_structure."
		end
	create_widgets_comment: STRING is
			-- Comment to be inserted into generated code before
			-- the widgets are created.
		once
			Result := indent + "%T-- Create all widgets."
		end
		
	set_widgets_comment: STRING is
			-- Comment to be inserted into generated code before the
			-- widgets attributes are set.
		once
			Result := indent + "%T-- Initialize properties of all widgets."
		end
		
feature -- Wizard

	wizard_completion_file_name: STRING is "completion_status.txt"
		
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
		
	Events_string: STRING is "Events"
		-- String constant representing `Events'.
	
	Event_string: STRING is "Event"
		-- String constant representing `Event'.
	
feature -- Dialogs

	b_OK: STRING is "OK"
	
	b_Cancel: STRING is "Cancel"
	
	b_Apply: STRING is "Apply"

	Save_prompt: STRING is "Do you wish to save the current project?"
	
	application_class_name_prompt: STRING is "Application class name :"
	
	window_class_name_prompt: STRING is "Window class name :"
	
	project_name_prompt: STRING is "Project name :"
	
feature -- Miscellaneous

	Event_selection_text: STRING is "Select events"
		-- Displayed on button in object editor which pops
		-- up event dialog.
	
	Event_modification_text: STRING is "Modify events"
		-- Displayed on button in object editor which pops
		-- up event dialog.
	
feature -- Warning Dialogs

	Exit_warning: STRING is "Are you sure you wish to Exit?"
		-- Displayed in a dialog when user attempts to quit.
	
	Exit_save_warning: STRING is "The project has not been saved.%NDo you wish to save it before exiting?"
		-- Dispalyed in a dialog when user attempts to quit with an unsave project.

	Object_editor_button_warning: STRING is "Please drop an object on this button%NUse right click for both pick and drop actions."
	
	Component_tool_button_warning: STRING is "Please drop a component on this button%NUse right click for both pick and drop actions."
	
	Project_exists_warning: STRING is "A Build project already exists in the selected directory. Do you wish to overwrite this project?"

	Invalid_project_warning: STRING is "Invalid build project file. Please select a different file."
		-- Warning displayed when a user attempts to open an invalid build project.

	Duplicate_name_warning_part1: STRING is "'"
		-- First part of warning used when a name that already exists is entered.
		
	Duplicate_name_warning_part2: STRING is "' Is not a valid object name.%N%NPossible causes include :-%N   Name already used as object name in system.%N   Name already used as feature name in system%N   Name is an Eiffel reserved word.%N%NSelecting 'Modify' will allow editing of current invalid name.%NSelecting 'Cancel' will restore old name."
		-- Second part of warning used when a name that already exists is entered.

	Delete_component_warning: STRING is "Are you sure you wish to delete the component from the system?"

	Class_invalid_name_warning: STRING is "' is not a valid Class name.%NClass names should only include%N%
		%alphanumeric characters or underscores,%Nand start with an alphabetic character.%N%
		%Please select a different class name."
		
	Reserved_word_warning: STRING is "' is a reserved word.%NPlease select a different class name."

	Component_invalid_name_warning: STRING is " is not a valid Component name.%NComponent names should only include%N%
		%alphanumeric characters or underscores,%Nand start with an alphabetic character.%N%
		%please select a different component name."
		
	Event_feature_name_warning: STRING is "Please correct invalid feature names (highlighted in red).%N%NPossible causes include :-%N   Name already used as object name in system.%N   Name already used as feature name in system%N   Name is an Eiffel reserved word."
	
	Duplicate_event_feature_name_warning: STRING is "You have specified two identical feature names.%N All feature names must be unique.%N%NPlease resolve this conflict."
		
	Component_identical_name_warning: STRING is " is already used as a component name.%NPlease enter a unique component name."
	
	Windows_unsupported_pixmap_type: STRING is "File type not supported. BMP, ICO and PNG file types supported."
	
	Unix_unsupported_pixmap_type: STRING is "File type not supported. PNG and XPM file types supported."
	
	Matching_class_and_application_names_warning: STRING is "Application and class names conflict."

end -- class GB_CONSTANTS
