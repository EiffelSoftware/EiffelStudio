indexing
	description: "Objects that provide access to constants used in EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_CONSTANTS
	
inherit
	ANY	

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
		
	Envision_build_wizard_title: STRING is "Advanced GUI Project Wizard"
		-- title displayed in wizard mode.
	
feature -- Menu texts.
	
	Gb_file_menu_text: STRING is "&File"
		-- Text of file menu.
		
	Gb_file_exit_menu_text: STRING is "&Exit"
		
	Gb_help_about_menu_text: STRING is "&About..."
	
	Gb_help_tip_of_day_menu_text: STRING is "Tip of the Day..."
	
	Gb_help_menu_text: STRING is "&Help"
	
	Gb_project_menu_text: STRING is "Project"
	
	Gb_project_menu_build_text: STRING is "Build"

	Gb_project_menu_settings_text: STRING is "&Settings"
	
	Gb_view_menu_text: STRING is "&View"
	
	Gb_view_preferences_text: STRING is "Preferences"
	
	Gb_view_tools_text: STRING is "Tools"
	
	Show_hide_component_viewer_menu_text: STRING is "Component viewer"
	
	Show_hide_builder_window_menu_text: STRING is "Builder window"
	
	Show_hide_display_window_menu_text: STRING is "Display window"
	
	Show_hide_history_window_menu_text: STRING is "History window"
	
	Show_hide_constants_window_menu_text: STRING is "Constants"
	
	Show_tool_windows_modeless_text: STRING is "Tools always on top?%TCtrl+T"
	
feature -- String representations of class names.

	Gb_primitive_object_class_name: STRING is "GB_PRIMITIVE_OBJECT"
	
	Gb_cell_object_class_name: STRING is "GB_CELL_OBJECT"
	
	Gb_container_object_class_name: STRING is "GB_CONTAINER_OBJECT"
	
	Ev_window_string: STRING is "EV_WINDOW"
	
	Ev_titled_window_string: STRING is "EV_TITLED_WINDOW"
	
	Ev_dialog_string: STRING is "EV_DIALOG"
	
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
	
	gb_ev_container: STRING is "GB_EV_CONTAINER"
	
feature -- GB_EV_FIXED

	select_widget_prompt: STRING is "Please select desired widget."
	
	resize_widget_prompt: STRING is "Highlighted widget is positionable"
	
	widget_size_prompt: STRING is "Widget is 0x0 pixels, click HERE to enlarge."

feature -- Miscellaneous

	Internal_properties_string: STRING is "Internal_properties"
		-- XML tag used to store properties stored by GB_OBJECT
		-- but not in the interface of Vision2.
		
	Directory_string: STRING is "Directory"
		-- XML tag used to represent a directory.
		
	Directory_seperator: CHARACTER is
			-- Seperator used for directories on current platform.
		once
			Result := (create {OPERATING_ENVIRONMENT}).directory_separator
		end

feature -- Default values

	Minimum_width_of_object_editor: INTEGER is 165
		-- The minimum width allowed for a GB_OBJECT_EDITOR
		
	Default_floating_object_editor_height: INTEGER is 500
		-- The default height of a newly created floating object editor window.
		
	Default_window_dimension: INTEGER is 125
		-- Default sizes of builder and display window when displayed.
		
	Default_width_of_type_selector: INTEGER is 180
		-- The default width of the type selector.
		
	Default_height_of_type_selector: INTEGER is 250
		-- The default_height of the type selector.
		
	Spacing_to_holder_tool_bar: INTEGER is 8
		-- The distance between a tool holders label and any associated tool bar.
		
	Tool_minimum_height: INTEGER is 50
		-- The minimum height of each main tool.

feature -- Generation constants
		
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
	
	constants_tag: STRING is
			-- `Result' is tag used in templated
			-- for the constants declaration.
		once
			Result := "<CONSTANTS>"
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
		
	inheritance_tag: STRING is
			-- `Result' is tag used in templates
			-- for the inheritance.
		once
			Result := "<INHERITANCE>"
		end
		
	precursor_tag: STRING is
			-- `Result' is tag used in tamples
			-- for precursor.
		once
			Result := "<PRECURSOR>"
		end
		
	creation_tag: STRING is
			--`Result' is tag used in templates
			-- for creation.
		once
			Result := "<CREATION>"
		end
		
	custom_feature_tag: STRING is
			-- `Result' is tag used in templates for custom features.
		once
			Result := "<CUSTOM_FEATURE>"
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
			Result := "%N%T"
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
		
	merged_groups_string: STRING is "merged_radio_button_groups"
	
	redefined_creation: STRING is
			--Definition of `make_with_window' and `default_create' to be used in window implementation when
			-- we are a client of the window, and not inheriting it.
		once
			Result := "create" + indent_less_two + "default_create," + indent_less_two +
				"make_with_window%N%N" + "feature {NONE} -- Initialization%N" + indent_less_two +
				"make_with_window (a_window: "+ Ev_titled_window_string + ") is" + indent + "-- Create `Current' in `a_window'." +
				indent_less_one + "require" + indent + "window_not_void: a_window /= Void" +
				indent + "window_empty: a_window.is_empty" + indent + "no_menu_bar: a_window.menu_bar = Void" +
				indent_less_one + "do" + indent + "window := a_window" + indent + "initialize" + indent_less_one + "ensure" + indent + "window_set: window = a_window" + indent + "window_not_void: window /= Void" + indent_less_one + "end%N" +
				indent_less_two + "default_create is" + indent + " -- Create `Current'." + indent_less_one + "do" + indent +
				"create window" + indent + "initialize" + indent_less_one + "ensure then" + indent + "window_not_void: window /= Void" + indent_less_one + "end"
		end
	
	default_create_redefinition: STRING is
			-- Redefinition of `default_create' used when we are a client of the window.
		once
			Result := indent_less_one + "redefine" + indent + "default_create" + indent_less_one + "end"
		end
		
	show_feature: STRING is
			-- `Show' for the window implementation when we are a client of the window.
		once
			Result := indent_less_two + "show is" + indent + "-- Show `Current'." + indent_less_one + "do" + indent + client_window_string +
			".show" + indent_less_one + "end"
		end

	window_inheritance_part1: STRING is
			-- Part 1 of string used to generate inheritance from window in implementation class.
		once
			Result := "inherit" + Indent_less_two + Ev_titled_window_string + Indent_less_one + "redefine" + indent +
			"initialize, is_in_default_state" + Indent_less_one + "end" + indent + indent_less_two
		end
	
	window_inheritance_part2: STRING is
			-- Part 2 of string used to generate inheritance from window in implementation class.
		once
			Result := Indent_less_one + "undefine" + indent + "is_equal, default_create, copy" + Indent_less_one + "end"
		end
		
	window_access: STRING is
			-- String used to define window when we are a client of window.
		once
			Result := "inherit" + Indent_less_two + "CONSTANTS%N%Nfeature -- Access%N" + indent_less_two +
			"window: " + Ev_titled_window_string + indent_less_one + "-- `Result' is window with which `Current' is implemented"
		end
		
	window_access_as_dialog_part1: STRING is
			-- Part 1 of string used to define window when we are a client of window.
		once
			Result := "inherit" + Indent_less_two
		end
	window_access_as_dialog_part2: STRING is
			-- Part 2 of string used to define window when we are client of window.
		once
			Result := "%N%Nfeature -- Access%N" + indent_less_two + "window: " + Ev_titled_window_string + indent_less_one +
				"-- `Result' is dialog with which `Current' is implemented"
		end
		
	client_window_string: STRING is "window"
		-- Name used to access window as a client.

	Create_command_string: STRING is "create "
			-- String corresponding to creation instruction in generated_code.

	Optimal_string: STRING is "Optimal"

feature -- Wizard

	wizard_completion_file_name: STRING is "completion_status.txt"
		
feature -- XML constants


	True_string: STRING is "True"
		-- String constant representing True.
		
	False_string: STRING is "False"
		-- String constant representing False.
		
	Item_string: STRING is "item"
		-- String constant representing "item".
		
	Name_string: STRING is "name"
		-- String constant representing "name".
		
	Id_String: STRING is "id"
		-- String constant representing "id".
	
	Schema_instance: STRING is "http://www.w3.org/1999/XMLSchema-instance"
		-- Schema information for inclusion in XML files.
		
	Events_string: STRING is "Events"
		-- String constant representing `Events'.
	
	Event_string: STRING is "Event"
		-- String constant representing `Event'.
		
	Root_window_string: STRING is "Is_root_window"
		-- String constant used for root window of system
	
feature -- Dialogs

	b_OK: STRING is "OK"
	
	b_Cancel: STRING is "Cancel"
	
	b_Apply: STRING is "Apply"

	Save_prompt: STRING is "Do you wish to save the current project?"
	
feature -- Miscellaneous

	select_constant_string: STRING is "Select constant..."
		-- Used in constant selection dialogs.
		
	Event_selection_text: STRING is "Select events..."
		-- Displayed on button in object editor which pops
		-- up event dialog.
	
	Event_modification_text: STRING is "Modify events..."
		-- Displayed on button in object editor which pops
		-- up event dialog.
		
	Comment_start_string: STRING is "-- Actions to be performed when"
		-- Text presumed to be at start of all action sequence comments.
		
	application: EV_APPLICATION is
			-- Once instance of EV_APPLICATION.
			-- Defined here for speed, so it can be accessed
			-- without being re-created everywhere.
			-- in Build, the application will never change.
		once
			Result := environment.application
		end
		
	environment: EV_ENVIRONMENT is
			-- Once instance of EV_ENVIRONMENT.
			-- Defined here for speed, so it can be accessed
			-- without being re-created everwhere.
		once
			create Result
		end
		
feature -- GB_TOOL_HOLDER constants

	maximize_tooltip: STRING is "Maximize"
	minimize_tooltip: STRING is "Minimize"
	restore_tooltip: STRING is "Restore"
		
	
feature -- Warning Dialogs

	Exit_warning: STRING is "Are you sure you wish to Exit?"
		-- Displayed in a dialog when user attempts to quit.
	
	Exit_save_warning: STRING is "The project has not been saved.%NDo you wish to save it before exiting?"
		-- Dispalyed in a dialog when user attempts to quit with an unsave project.

	Object_editor_button_warning: STRING is "Please drop an object on this button%NUse right click for both pick and drop actions."
	
	Component_tool_button_warning: STRING is "Please drop a component on this button%NUse right click for both pick and drop actions."
	
	Project_exists_warning: STRING is "An EiffelBuild project already exists in the selected directory. Do you wish to overwrite this project?"
	
	Directory_exists_warning: STRING is "The selected directory does not exist. Would you like to create it?"

	Invalid_project_warning: STRING is "Invalid EiffelBuild project file. Please select a different file."
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

	Component_invalid_name_warning: STRING is " is not a valid Component name.%N%NComponent names must be unique, start with an alphabetic character%Nand only include alphanumeric characters and underscores.%N%NPlease select a different component name."
		
	Event_feature_name_warning: STRING is "Please correct invalid feature names (highlighted in red).%N%NPossible causes include :-%N   Name already used as object name in system.%N   Name already used as feature name in system%N   Name is an Eiffel reserved word."
	
	Duplicate_event_feature_name_warning: STRING is "You have specified two identical feature names.%N All feature names must be unique.%N%NPlease resolve this conflict."
		
	Component_identical_name_warning: STRING is " is already used as a component name.%NPlease enter a unique component name."
	
	Windows_unsupported_pixmap_type: STRING is "File type not supported. BMP, ICO and PNG file types supported."
	
	Unix_unsupported_pixmap_type: STRING is "File type not supported. PNG and XPM file types supported."
	
	Matching_class_and_application_names_warning: STRING is "Application and class names conflict."
	
	Invalid_bpr_file: STRING is "The .BPR file you are attempting to load was created with the beta version of EiffelBuild.%NThe information stored in the project settings are incompatible with this version of EiffelBuild.%NClick 'Continue' if you wish to load the project, with default EiffelBuild settings."
	
	Not_all_windows_named_string: STRING is "Some of the windows you are attempting to generate are not named.%NThe name is required for the generation and is used for both the class and file names.%NDo you wish to assign default names to those windows that are unnamed?"
	
	constant_rejected_warning: STRING is "The value of the selected constant does not lie within the range permitted for this%Nproperty, and thefore the constant has been rejected.%NThe range of permitted values is restricted by the properties and settings of each object."

feature -- Object editor properties

	gb_ev_widget_minimum_width: STRING is "Minimum Width"
	gb_ev_widget_minimum_width_tooltip: STRING is "feature `minimum_width' from EV_WIDGET."
	gb_ev_widget_minimum_height: STRING is "Minimum Height"
	gb_ev_widget_minimum_height_tooltip: STRING is "feature `minimum_height' from EV_WIDGET."
	
	gb_ev_gauge_value: STRING is "Value"
	gb_ev_gauge_value_tooltip: STRING is "feature `value' from EV_GAUGE."
	gb_ev_gauge_step: STRING is "Step"
	gb_ev_gauge_step_tooltip: STRING is "feature `step' from EV_GAUGE."
	gb_ev_gauge_leap: STRING is "Leap"
	gb_ev_gauge_leap_tooltip: STRING is "feature `leap' from EV_GAUGE."
	gb_ev_gauge_upper: STRING is "Upper"
	gb_ev_gauge_upper_tooltip: STRING is "feature `upper' from EV_GAUGE."
	gb_ev_gauge_lower: STRING is "Lower"
	gb_ev_gauge_lower_tooltip: STRING is "feature `lower' from EV_GAUGE."
	
	gb_ev_viewport_x_offset: STRING is "X Offset"
	gb_ev_viewport_x_offset_tooltip: STRING is "feature `x_offset' from EV_VIEWPORT"
	gb_ev_viewport_y_offset: STRING is "Y Offset"
	gb_ev_viewport_y_offset_tooltip: STRING is "feature `y_offset' from EV_VIEWPORT"
	gb_ev_viewport_item_height: STRING is "Item Height"
	gb_ev_viewport_item_height_tooltip: STRING is "feature `item_height' from EV_VIEWPORT"
	gb_ev_viewport_item_width: STRING is "Item Width"
	gb_ev_viewport_item_width_tooltip: STRING is "feature `item_width' from EV_VIEWPORT"
	
	gb_ev_window_user_can_resize: STRING is "User can resize?"
	gb_ev_window_user_can_Resize_tooltip: STRING is "feature `user_can_resize' from EV_WINDOW"
	gb_ev_window_title: STRING is "Title"
	gb_ev_window_title_tooltip: STRING is "feature `title' from EV_WINDOW"
	gb_ev_window_maximum_width: STRING is "Maximum Width"
	gb_ev_window_maximum_width_tooltip: STRING is "feature `maximum_width' from EV_WINDOW"
	gb_ev_window_maximum_height: STRING is "Maximum Height"
	gb_ev_window_maximum_height_tooltip: STRING is "feature `maximum_height' from EV_WINDOW"
	
	gb_ev_box_padding_width: STRING is "Padding Width"
	gb_ev_box_padding_width_tooltip: STRING is "feature `padding_width' from EV_BOX"
	gb_ev_box_border_width: STRING is "Border Width"
	gb_ev_box_border_width_tooltip: STRING is "feature `border_width' from EV_BOX"
	
	gb_ev_table_rows: STRING is "Rows"
	gb_ev_table_rows_tooltip: STRING is "feature `rows' from EV_TABLE"
	gb_ev_table_columns: STRING is "Columns"
	gb_ev_table_columns_tooltip: STRING is "feature `columns' from EV_TABLE"
	gb_ev_table_row_spacing: STRING is "Row Spacing"
	gb_ev_table_row_spacing_tooltip: STRING is "feature `row_spacing' from EV_TABLE"
	gb_ev_table_column_spacing: STRING is "Column Spacing"
	gb_ev_table_column_spacing_tooltip: STRING is "feature `column_spacing' from EV_TABLE"
	gb_ev_table_border_width: STRING is "Border Width"
	gb_ev_table_border_width_tooltip: STRING is "feature `border_width' from EV_TABLE"
	
	gb_ev_colorizable_foreground_color: STRING is "Foreground color"
	gb_ev_colorizable_foreground_color_tooltip: STRING is "feature `foreground_color' from GB_EV_COLORIZABLE"
	gb_ev_colorizable_background_color: STRING is "Background color"
	gb_ev_colorizable_background_color_tooltip: STRING is "feature `background_color' from GB_EV_COLORIZABLE"
	gb_ev_colorizable_restore_color: STRING is "Restore"
	background_color_restore: STRING is " Restore background color to default."
	foreground_color_restore: STRING is " Restore foreground color to default."
	
	gb_ev_deselectable_is_selected: STRING is "Is Selected?"
	gb_ev_deselectable_is_selected_tooltip: STRING is "feature `is_selected' from EV_SELECTABLE"
	
	gb_ev_sensitive_is_sensitive: STRING is "Is Sensitive?"
	gb_ev_sensitive_is_sensitive_tooltip: STRING is "feature `is_sensitive' from EV_SENSITIVE"
	
	gb_ev_tool_bar_has_vertical_button_style: STRING is "Vertical button style?"
	gb_ev_tool_bar_has_vertical_button_style_tooltip: STRING is "feature `has_vertical_button_style' from EV_TOOL_BAR"
	
	
	gb_ev_textable_text: STRING is "Text"
	gb_ev_textable_text_tooltip: STRING is "feature `text' from EV_TEXTABLE"
	
	gb_ev_text_alignable: STRING is "Text alignment"
	gb_ev_text_alignable_tooltip: STRING is "feature `text_alignment' from EV_TEXT_ALIGNABLE"
	
	gb_ev_tooltipable_tooltip: STRING is "Tooltip"
	gb_ev_tooltipable_tooltip_tooltip: STRING is "feature `tooltip' from EV_TOOLTIPABLE"
	
	gb_ev_pixmapable_pixmap: STRING is "Pixmap"
	gb_ev_pixmapable_pixmap_tooltip: STRING is "feature `pixmap' from EV_PIXMAPABLE"
	
	gb_ev_pixmap_pixmap: STRING is "Pixmap image"
	gb_ev_pixmap_pixmap_tooltip: STRING is "feature `set_with_named_file' from EV_PIXMAP"
	
	gb_ev_container_radio_groups: STRING is "Merged radio groups"
	gb_ev_container_radio_groups_tooltip: STRING is "feature `merge_radio_groups' from EV_CONTAINER"
	gb_ev_container_propagate_foreground_color: STRING is "Propagate"
	gb_ev_container_propagate_foreground_color_tooltip: STRING is "Propagate foreground color to all children."
	gb_ev_container_propagate_background_color: STRING is "Propagate"
	gb_ev_container_propagate_background_color_tooltip: STRING is "Propagate background color to all children."
	
	gb_ev_text_component_is_editable: STRING is "Is editable?"
	gb_ev_text_component_is_editable_tooltip: STRING is "feature `is_editable' from EV_TEXT_COMPONENT"
	
	gb_ev_notebook_tab_position: STRING is "Tab Position"
	gb_ev_notebook_tab_position_tooltip: STRING is "feature `tab_position' from EV_NOTEBOOK"
	
	gb_ev_progress_bar_is_segmented: STRING is "Is segmented?"
	gb_ev_progress_bar_is_segmented_tooltip: STRING is "feature `is_segmented' from EV_PROGRESS_BAR"
	
	select_button_text: STRING is "Select..."
	set_with_named_file_text: STRING is "Set with named file..."
	set_with_named_file_tooltip: STRING is "Set pixmap image with named file"
	clear_text: STRING is "Clear"
	clear_tooltip: STRING is "Clear pixmap image"
	pixmap_missing_string: STRING is "Error - named pixmap missing."
	invalid_pixmap_contents_warning: STRING is " does not contain a valid image. Possible causes for this are:-%N%NFile is not one of the supported image types.%NFile is corrupted.%N%NPlease select a diferent file."
	
	select_constant_tooltip: STRING is "Select constant"
	
	object_editor_padding_width: INTEGER is 3
	
feature -- Booleans

	multiple_line_entry: BOOLEAN is True
		-- Boolean value used to indicate that multiple line entry fields are required.
		
	single_line_entry: BOOLEAN is False
		-- Boolean value used to indicate that single line entry fields are required.
	
feature -- Constants

	Pixmap_constant_type: STRING is "PIXMAP"
		-- String representation of a pixmap constant.

	Integer_constant_type: STRING is "INTEGER"
		-- String representation of an integer constant.
	
	String_constant_type: STRING is "STRING"
		-- String representation of a string constant.
	
	directory_constant_type: STRING is "DIRECTORY"
		-- String representation of a directory constant.
		
	filepath_constant_type: STRING is "FILEPATH"
	
	filename_constant_type: STRING is "FILENAME"
	
	all_constant_type: STRING is "ALL"
		-- String representation used to indicate all constant types.
	
	type_string: STRING is "type"
		-- String used to match type within XML.
		
	constant_name_string: STRING is "Name"
		-- Used to represent a constant name in XML
	
	constant_value_string: STRING is "Value"
		-- Used to represent a constant value in XML
	
	Constants_string: STRING is "Constants"
		-- String constant representing constants in XML.
		
	Constant_string: STRING is "Constant"
		-- String constant representing single constant in XML.
		
	is_absolute_string: STRING is "is_absolute"
	
	filename_string: STRING is "Filename"
	
	invalid_pixmap_name_prefix: STRING is "pixmap_"
		-- Name prepended to pixmaps that are invalid.

feature -- Preferences

	constants_do_not_show_again: STRING is "Reject invalid constants, and do not show this dialog again."
	
	delete_do_not_show_again: STRING is "Always delete via the keyboard, and do not show again."
	
	delete_warning1: STRING is "The currently selected "
	
	delete_warning2: STRING is " will be deleted.%N%NAre you sure you wish to perform this?"

	show_repeated_absolute_constant_warning: STRING is "show_repeated_absolute_constant_warning"
	
	show_invalid_constant_selection_warning: STRING is "show_invalid_constant_selection_warning"
	
	show_constant_manifest_conversion_warning: STRING is "show_constant_manifest_conversion_warning"
	
	show_project_location_changed_warning: STRING is "show_project_location_changed_warning"
	
	show_adding_existing_directory_warning: STRING is "show_adding_existing_directory_warning"
	
feature -- Prompts

	select_directory_location_modify_string: STRING is "Please select new location for directory constant %""
		-- String displayed when selecting a new directroy during a modification of an existing directory constant.

end -- class GB_CONSTANTS
