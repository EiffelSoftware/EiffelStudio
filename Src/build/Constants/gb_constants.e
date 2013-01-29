note
	description: "Objects that provide access to constants used in EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_CONSTANTS

inherit
	ANY

feature -- Access

	Gb_display_window_title: STRING = "Display window"
		-- Title to be displayed in GB_DISPLAY_WINDOW.

	Gb_builder_window_title: STRING = "Builder window"
		-- Title to be displayed in GB_BUILDER_WINDOW.

	Gb_object_editor_window_title: STRING = "Object editor"
		-- Title to be displayed in GB_OBJECT_EDITOR.

	Product_name: STRING = "EiffelBuild"
		-- Name of system displayed to users.

	Class_argument: STRING = "class"
		-- Command line argument to start as class only.

feature -- Menu texts.

	Gb_file_menu_text: STRING = "&File"
		-- Text of file menu.

	Gb_file_exit_menu_text: STRING = "&Exit"

	Gb_help_about_menu_text: STRING = "&About..."

	Gb_help_tip_of_day_menu_text: STRING = "Tip of the Day..."

	Gb_help_menu_text: STRING = "&Help"

	Gb_project_menu_text: STRING = "Project"

	Gb_project_menu_build_text: STRING = "Build"

	Gb_project_menu_settings_text: STRING = "&Settings"

	Gb_view_menu_text: STRING = "&View"

	Gb_view_preferences_text: STRING = "Preferences"

	Gb_view_tools_text: STRING = "Tools"

	Show_hide_component_viewer_menu_text: STRING = "Component viewer"

	Show_hide_builder_window_menu_text: STRING = "Builder window"

	Show_hide_display_window_menu_text: STRING = "Display window"

	Show_hide_history_window_menu_text: STRING = "History window"

	Show_hide_constants_window_menu_text: STRING = "Constants"

	Show_tool_windows_modeless_text: STRING = "Tools always on top?%TCtrl+T"

feature -- String representations of class names.

	Gb_parent_object_class_name: STRING = "GB_PARENT_OBJECT"

	Gb_primitive_object_class_name: STRING = "GB_PRIMITIVE_OBJECT"

	Gb_cell_object_class_name: STRING = "GB_CELL_OBJECT"

	Gb_container_object_class_name: STRING = "GB_CONTAINER_OBJECT"

	Ev_window_string: STRING = "EV_WINDOW"

	Ev_titled_window_string: STRING = "EV_TITLED_WINDOW"

	Ev_dialog_string: STRING = "EV_DIALOG"

	Ev_menu_bar_string: STRING = "EV_MENU_BAR"

	menu_bar_string: STRING = "MENU_BAR"

	Ev_widget_string: STRING = "EV_WIDGET"

	Ev_cell_string: STRING = "EV_CELL"

	Ev_primitive_string: STRING = "EV_PRIMITIVE"

	Ev_tool_bar_string: STRING = "EV_TOOL_BAR"

	Ev_menu_string: STRING = "EV_MENU"

	Ev_menu_item_string: STRING = "EV_MENU_ITEM"

	Ev_tree_item_string: STRING = "EV_TREE_ITEM"

	Ev_container_string: STRING = "EV_CONTAINER"

	Ev_widget_list_string: STRING = "EV_WIDGET_LIST"

	Ev_notebook_string: STRING = "EV_NOTEBOOK"

	Ev_table_string: STRING = "EV_TABLE"

	Ev_split_area_string: STRING = "EV_SPLIT_AREA"

	Ev_list_string: STRING = "EV_LIST"

	Ev_combo_box_string: STRING = "EV_COMBO_BOX"

	Ev_tree_string: STRING = "EV_TREE"

	Ev_item_string: STRING = "EV_ITEM"

	Ev_tool_bar_item_string: STRING = "EV_TOOL_BAR_ITEM"

	Ev_list_item_string: STRING = "EV_LIST_ITEM"

	Ev_spin_button_string: STRING = "EV_SPIN_BUTTON"

	gb_ev_container: STRING = "GB_EV_CONTAINER"

feature -- GB_EV_FIXED

	select_widget_prompt: STRING = "Please select desired widget."

	resize_widget_prompt: STRING = "Highlighted widget is positionable"

	widget_size_prompt: STRING = "Widget is 0x0 pixels, click HERE to enlarge."

feature -- Default values

	Minimum_width_of_object_editor: INTEGER = 165
		-- The minimum width allowed for a GB_OBJECT_EDITOR

	Default_floating_object_editor_height: INTEGER = 500
		-- The default height of a newly created floating object editor window.

	Default_window_dimension: INTEGER = 125
		-- Default sizes of builder and display window when displayed.

	Default_width_of_type_selector: INTEGER = 180
		-- The default width of the type selector.

	Default_height_of_type_selector: INTEGER = 250
		-- The default_height of the type selector.

	Spacing_to_holder_tool_bar: INTEGER = 8
		-- The distance between a tool holders label and any associated tool bar.

	Tool_minimum_height: INTEGER = 50
		-- The minimum height of each main tool.

feature -- Generation constants

	class_name_tag: STRING
			-- `Result' is tag used in templates
			-- for the class name.
		once
			Result := "<CLASS_NAME>"
		end

	constant_resetting_tag: STRING
			-- `Result' is tag used in templates
			-- for resetting of constant values.
		once
			Result := "<CONSTANT_RESETTING>"
		end

	inherited_class_name_tag: STRING
			-- `Result' is tag used in templates
			-- for the inherited class name.
		once
			Result := "<INHERITED_CLASS_NAME>"
		end

	create_tag: STRING
			-- `Result' is tag used in templates
			-- for the creation of widgets.
		once
			Result := "<CREATE>"
		end

	build_tag: STRING
			-- `Result' is tag used in templates
			-- for building of the widget hierarchy.
		once
			Result := "<BUILD>"
		end

	set_tag: STRING
			-- `Result' is tag used in templates
			-- for the setting of widgets properties.
		once
			Result := "<SET>"
		end

	local_tag: STRING
			-- `Result' is tag used in templates
			-- for local definitions.
		once
			Result := "<LOCAL>"
		end

	constants_tag: STRING
			-- `Result' is tag used in templated
			-- for the constants declaration.
		once
			Result := "<CONSTANTS>"
		end

	main_window_tag: STRING
			-- `Result' is tag used in templates
			-- for the main window declaration.
		once
			Result := "<MAIN_WINDOW>"
		end

	project_location_tag: STRING
			-- `Result' is tag used in ace templates
			-- for the project location.
		once
			Result := "<PROJECT_LOCATION>"
		end

	event_connection_tag: STRING
			-- `Result' is tag used in templates
			-- for the event connection declarations.
		once
			Result := "<EVENT_CONNECTION>"
		end

	event_declaration_tag: STRING
			-- `Result' is tag used in templates
			-- for the event declarations.
		once
			Result := "<EVENT_DECLARATION>"
		end

	attribute_tag: STRING
			-- `Result' is tag used in templates
			-- for the attribute declarations.
		once
			Result := "<ATTRIBUTE>"
		end

	application_tag: STRING
			-- `Result' is tag used in templates for
			-- the application declaration.
		once
			Result := "<APPLICATION>"
		end

	project_name_tag: STRING
			--
		once
			Result := "<PROJECT_NAME>"
		end

	inheritance_tag: STRING
			-- `Result' is tag used in templates
			-- for the inheritance.
		once
			Result := "<INHERITANCE>"
		end

	precursor_tag: STRING
			-- `Result' is tag used in tamples
			-- for precursor.
		once
			Result := "<PRECURSOR>"
		end

	creation_tag: STRING
			--`Result' is tag used in templates
			-- for creation.
		once
			Result := "<CREATION>"
		end

	custom_feature_tag: STRING
			-- `Result' is tag used in templates for custom features.
		once
			Result := "<CUSTOM_FEATURE>"
		end

	uuid_tag: STRING = "<UUID>"
			-- Tag used in templates for generating a new UUID.

	clr_version_tag: STRING
			-- Used in templates as clr setting.
		once
			Result := "<CLR_VERSION>"
		end


	indent: STRING
			-- String representing standard indent
			-- for code generation.
		once
			Result := indent_less_one + "%T"
		end

	indent_less_one: STRING
			-- String representing an indent one
			-- tabs less than `indent'.
		once
			Result := indent_less_two + "%T"
		end

	indent_less_two: STRING
			-- String representing an indent two
			-- tabs less than `indent'.
		once
			Result := "%N%T"
		end

	Local_object_name_prepend_string: STRING = "l_"
			-- generated local variables are of the form
			-- `Result' + short type + number.
			-- i.e. l_button1

	pixmap_name: STRING = "internal_pixmap"
		-- Name of temporary pixmap used during generation
		-- of pixmap setting code.

	class_implementation_extension: STRING = "_IMP"
		-- Extension to be added to generated class name,
		-- for the implementation class.

	connect_events_comment: STRING
			-- Comment to be inserted into generated code before
			-- the event connections are declared.
		once
			Result := indent + "%T-- Connect events."
		end

	build_widgets_comment: STRING
			-- Comment to be inserted into generated code before
			-- the widgets are parented.
		once
			Result := indent + "%T-- Build widget structure."
		end
	create_widgets_comment: STRING
			-- Comment to be inserted into generated code before
			-- the widgets are created.
		once
			Result := indent + "%T-- Create all widgets."
		end

	set_widgets_comment: STRING
			-- Comment to be inserted into generated code before the
			-- widgets attributes are set.
		once
			Result := indent + "%T-- Initialize properties of all widgets."
		end

	merged_groups_string: STRING = "merged_radio_button_groups"

	redefined_window_creation: STRING
			--Definition of `make_with_window' and `default_create' to be used in window implementation when
			-- we are a client of the window, and not inheriting it.
		once
			Result := "[
create
	default_create,
	make_with_window
	
feature {NONE} -- Initialization

	make_with_window (a_window: like window)
			-- Create `Current' in `a_window'.
		require
			window_not_void: a_window /= Void
			window_empty: a_window.is_empty
			no_menu_bar: a_window.menu_bar = Void
		do
			window := a_window
			create_interface_objects
			initialize
		ensure
			window_set: window = a_window
			window_not_void: window /= Void
		end

	default_create
			 -- Create `Current'.
		do
			make_with_window (create {like window})
		ensure then
			window_not_void: window /= Void
		end
				]"
		end

	redefined_creation: STRING
			--Definition of `make_with_window' and `default_create' to be used in window implementation when
			-- we are a client of the window, and not inheriting it.
		once
			Result := "[
create
	default_create,
	make_with_widget

feature {NONE} -- Initialization

	make_with_widget (a_widget: like widget)
			-- Create `Current' in `a_widget'.
		require
			widget_not_void: a_widget /= Void
		do
			widget := a_widget
			create_interface_objects
			initialize
		ensure
			widget_set: widget = a_widget
			widget_not_void: widget /= Void
		end

	default_create
			 -- Create `Current'.
		do
			make_with_widget (create {like widget})
		ensure then
			widget_not_void: widget /= Void
		end
				]"
		end

	default_create_redefinition: STRING
			-- Redefinition of `default_create' used when we are a client of the window.
		once
			Result := indent_less_one + "redefine" + indent + "default_create" + indent_less_one + "end"
		end

	show_window_feature: STRING
			-- `Show' for the window implementation when we are a client of the window.
		once
			Result := indent_less_two + "show" + indent + "-- Show `Current'." + indent_less_one + "do" + indent + client_window_string +
			".show" + indent_less_one + "end"
		end

	show_widget_feature: STRING
			-- `Show' for the window implementation when we are a client of the window.
		once
			Result := indent_less_two + "show" + indent + "-- Show `Current'." + indent_less_one + "do" + indent + client_widget_string +
			".show" + indent_less_one + "end"
		end

	window_inheritance_part1: STRING
			-- Part 1 of string used to generate inheritance from window in implementation class.
		once
			Result := "inherit" + Indent_less_two + Ev_titled_window_string + Indent_less_one + "redefine" + indent +
			"create_interface_objects, initialize, is_in_default_state" + Indent_less_one + "end" + indent + indent_less_two
		end

	window_inheritance_no_constant: STRING
			-- Part 1 of string used to generate inheritance from window in implementation class.
		once
			Result := "inherit" + Indent_less_two + Ev_titled_window_string + Indent_less_one + "redefine" + indent +
			"create_interface_objects, initialize, is_in_default_state" + Indent_less_one + "end"
		end

	window_inheritance_part2: STRING
			-- Part 2 of string used to generate inheritance from window in implementation class.
		once
			Result := Indent_less_one + "undefine" + indent + "is_equal, default_create, copy" + Indent_less_one + "end"
		end

	client_window_string: STRING = "window"
		-- Name used to access window as a client.

	client_widget_string: STRING = "widget"
		-- Name used to access widget as a client.

	Create_command_string: STRING = "create "
			-- String corresponding to creation instruction in generated_code.

	False_optimal_string: STRING = "Optimal"

	False_non_exported_string: STRING = "False_exported"

	item_text_string: STRING = "Item_text"
		-- Constant used for referencing notebook item texts in XML.

	Item_pixmap_string: STRING = "Item_pixmap"
		-- String used to represent the pixmap of the notebook tabs in the XML

	font_string: STRING = "Font"
	font_family_string: STRING = "Family"
	font_weight_string: STRING = "Weight"
	font_shape_string: STRING = "Shape"
	font_height_string: STRING = "Height"
	font_height_points_string: STRING = "Height_in_points"
	font_preferred_family_string: STRING = "Preferred_family"

	background_color_string: STRING = "Background_color"
	foreground_color_string: STRING = "Foreground_color"

feature -- XML constants


	True_string: STRING = "True"
		-- String constant representing True.

	False_string: STRING = "False"
		-- String constant representing False.

	Item_string: STRING = "item"
		-- String constant representing "item".

	Reference_id_string: STRING = "reference_id"
		-- String constant representing "reference_id".

	Name_string: STRING = "name"
		-- String constant representing "name".

	client_string: STRING = "generate_as_client"
		-- String constant reflecting client generation option.

	Id_String: STRING = "id"
		-- String constant representing "id".

	Schema_instance: STRING = "http://www.w3.org/1999/XMLSchema-instance"
		-- Schema information for inclusion in XML files.

	Events_string: STRING = "Events"
		-- String constant representing `Events'.

	Event_string: STRING = "Event"
		-- String constant representing `Event'.

	Root_window_string: STRING = "Is_root_window"
		-- String constant used for root window of system

feature -- Dialogs

	b_OK: STRING = "OK"

	b_Cancel: STRING = "Cancel"

	b_Apply: STRING = "Apply"

	Save_prompt: STRING = "Do you wish to save the current project?"

feature -- Miscellaneous

	initial_main_window_name: STRING = "main_window"
		-- Name of initial main window added to system.

	select_constant_string: STRING = "Select constant..."
		-- Used in constant selection dialogs.

	Event_selection_text: STRING = "Select events..."
		-- Displayed on button in object editor which pops
		-- up event dialog.

	Event_modification_text: STRING = "Modify events..."
		-- Displayed on button in object editor which pops
		-- up event dialog.

	Comment_start_string: STRING = "-- Actions to be performed when"
		-- Text presumed to be at start of all action sequence comments.

	application: EV_APPLICATION
			-- Once instance of EV_APPLICATION.
			-- Defined here for speed, so it can be accessed
			-- without being re-created everywhere.
			-- in Build, the application will never change.
		once
			Result := environment.application
		end

	environment: EV_ENVIRONMENT
			-- Once instance of EV_ENVIRONMENT.
			-- Defined here for speed, so it can be accessed
			-- without being re-created everwhere.
		once
			create Result
		end

	Internal_properties_string: STRING = "Internal_properties"
		-- XML tag used to store properties stored by GB_OBJECT
		-- but not in the interface of Vision2.

	Directory_string: STRING = "Directory"
		-- XML tag used to represent a directory.

	maximum_supported_ascii_value: INTEGER = 127
		-- Maximum ascii character permitted in EiffelBuild save files.
		-- Currently it is limited to 127 by the GOBO implementation.
		--| FIXME Julian

	amount_to_shift_ids_during_import: INTEGER = 32000
		-- Amount by which all existing ids are shifted to permit the new obejcts to be loaded.
		-- This means that you cannot import a file that has ids greater than 32000 as otherwise there
		-- will be clashes.

feature -- GB_TOOL_HOLDER constants

	maximize_tooltip: STRING = "Maximize"
	minimize_tooltip: STRING = "Minimize"
	restore_tooltip: STRING = "Restore"


feature -- Warning Dialogs

	Exit_warning: STRING = "Are you sure you wish to Exit?"
		-- Displayed in a dialog when user attempts to quit.

	Exit_save_warning: STRING = "The project has not been saved.%NDo you wish to save it before exiting?"
		-- Dispalyed in a dialog when user attempts to quit with an unsave project.

	Object_editor_button_warning: STRING = "Please drop an object on this button%NUse right click for both pick and drop actions."

	Component_tool_button_warning: STRING = "Please drop a component on this button%NUse right click for both pick and drop actions."

	Project_exists_warning: STRING = "An EiffelBuild project already exists in the selected directory. Do you wish to overwrite this project?"

	Directory_exists_warning: STRING = "The selected directory does not exist. Would you like to create it?"

	Invalid_project_warning: STRING = "Invalid EiffelBuild project file. Please select a different file."
		-- Warning displayed when a user attempts to open an invalid build project.

	Duplicate_name_warning_part1: STRING = "'"
		-- First part of warning used when a name that already exists is entered.

	Duplicate_name_warning_part2: STRING = "' Is not a valid object name.%N%NPossible causes include :-%N   Name already used as object name in system.%N   Name already used as feature name in system%N   Name is an Eiffel reserved word.%N%NSelecting 'Modify' will allow editing of current invalid name.%NSelecting 'Cancel' will restore old name."
		-- Second part of warning used when a name that already exists is entered.

	Delete_component_warning: STRING = "Are you sure you wish to delete the component from the system?"

	Class_invalid_name_warning: STRING = "' is not a valid Class name.%NClass names should only include%N%
		%alphanumeric characters or underscores,%Nand start with an alphabetic character.%N%
		%Please select a different class name."

	Reserved_word_warning: STRING = "' is a reserved word.%NPlease select a different class name."

	Component_invalid_name_warning: STRING = " is not a valid Component name.%N%NComponent names must be unique, start with an alphabetic character%Nand only include alphanumeric characters and underscores.%N%NPlease select a different component name."

	Object_invalid_name_warning: STRING = " is not a valid object name.%N%NObject names must be unique, start with an alphabetic character%Nand only include alphanumeric characters and underscores.%N%NPlease select a different object name."

	Event_feature_name_warning: STRING = "Please correct invalid feature names (highlighted in red).%N%NPossible causes include :-%N   Name already used as object name in system.%N   Name already used as feature name in system%N   Name is an Eiffel reserved word."

	Duplicate_event_feature_name_warning: STRING = "You have specified two identical feature names.%N All feature names must be unique.%N%NPlease resolve this conflict."

	Component_identical_name_warning: STRING = " is already used as a component name.%NPlease enter a unique component name."

	Windows_unsupported_pixmap_type: STRING = "File type not supported. BMP, ICO and PNG file types supported."

	Unix_unsupported_pixmap_type: STRING = "File type not supported. PNG and XPM file types supported."

	Matching_class_and_application_names_warning: STRING = "Application and class names conflict."

	Invalid_bpr_file: STRING = "The .BPR file you are attempting to load was created with the beta version of EiffelBuild.%NThe information stored in the project settings are incompatible with this version of EiffelBuild.%NClick 'Continue' if you wish to load the project, with default EiffelBuild settings."

	Not_all_windows_named_string: STRING = "Some of the windows you are attempting to generate are not named.%NThe name is required for the generation and is used for both the class and file names.%NDo you wish to assign default names to those windows that are unnamed?"

	constant_rejected_warning: STRING = "The value of the selected constant does not lie within the range permitted for this%Nproperty, and thefore the constant has been rejected.%NThe range of permitted values is restricted by the properties and settings of each object."

	invalid_characters1: STRING = "EiffelBuild only supports standard ascii characters in the range 0 to 127.%NThe project contains the following unsupported ascii characters : %N%N"

	invalid_characters2: STRING = "%N%NIf you continue, these characters will be replaced by the character '*' in the save file (not the open project).%N%NDo you wish to continue saving?"

	cannot_delete_as_still_referenced_multiple: STRING = "The top level object you are attempting to delete is still referenced by multiple objects."

	cannot_delete_as_still_referenced_single: STRING = "The top level object you are attempting to delete is still referenced by a single object."

	cannot_delete_as_still_referenced_part2: STRING = "%NTo examine the current references of an object, open the client node of the object's representation within the Widget Selector.%N%NDo you wish to flatten all references and delete the object?"

	cyclic_inheritance_error: STRING = "Not permitted as causes a cyclic inheritance structure."

	changing_client_warning: STRING = "You are attempting to change the client status of a class that%Nhas already been generated and exists on disk%N%NThis change may cause the generated implementation file and%Nyour current interface file to no longer compile without modification%N%NAre you sure you wish to perform this?"

	unable_to_save_part1: STRING_32 = "Unable to save the following file :%N%N"
	unable_to_save_part2: STRING = "%N%NPlease check file permissions and try again."
	unable_to_save_part2_components: STRING = "%N%NModified components will not be saved."

	invalid_generation_directory: STRING = "The directory specified for code generation is invalid.%NPlease check this directory from the %"Generation%"%Ntab of the project settings dialog and correct it as necessary.%N%NNo code has been generated."


feature -- Object editor properties

	gb_ev_widget_is_show_requested: STRING = "Is Show Requested?"
	gb_ev_widget_is_show_requested_tooltip: STRING = "feature `is_displayed' from EV_WIDGET"
	gb_ev_widget_minimum_width: STRING = "Minimum Width"
	gb_ev_widget_minimum_width_tooltip: STRING = "feature `minimum_width' from EV_WIDGET."
	gb_ev_widget_minimum_height: STRING = "Minimum Height"
	gb_ev_widget_minimum_height_tooltip: STRING = "feature `minimum_height' from EV_WIDGET."

	gb_ev_fontable_font: STRING = "Font"
	gb_ev_fontable_font_tooltip: STRING = "feature `font' from EV_FONTABLE."

	gb_ev_gauge_value: STRING = "Value"
	gb_ev_gauge_value_tooltip: STRING = "feature `value' from EV_GAUGE."
	gb_ev_gauge_step: STRING = "Step"
	gb_ev_gauge_step_tooltip: STRING = "feature `step' from EV_GAUGE."
	gb_ev_gauge_leap: STRING = "Leap"
	gb_ev_gauge_leap_tooltip: STRING = "feature `leap' from EV_GAUGE."
	gb_ev_gauge_upper: STRING = "Upper"
	gb_ev_gauge_upper_tooltip: STRING = "feature `upper' from EV_GAUGE."
	gb_ev_gauge_lower: STRING = "Lower"
	gb_ev_gauge_lower_tooltip: STRING = "feature `lower' from EV_GAUGE."

	gb_ev_viewport_x_offset: STRING = "X Offset"
	gb_ev_viewport_x_offset_tooltip: STRING = "feature `x_offset' from EV_VIEWPORT"
	gb_ev_viewport_y_offset: STRING = "Y Offset"
	gb_ev_viewport_y_offset_tooltip: STRING = "feature `y_offset' from EV_VIEWPORT"
	gb_ev_viewport_item_height: STRING = "Item Height"
	gb_ev_viewport_item_height_tooltip: STRING = "feature `item_height' from EV_VIEWPORT"
	gb_ev_viewport_item_width: STRING = "Item Width"
	gb_ev_viewport_item_width_tooltip: STRING = "feature `item_width' from EV_VIEWPORT"

	gb_ev_window_user_can_resize: STRING = "User can resize?"
	gb_ev_window_user_can_Resize_tooltip: STRING = "feature `user_can_resize' from EV_WINDOW"
	gb_ev_window_title: STRING = "Title"
	gb_ev_window_title_tooltip: STRING = "feature `title' from EV_WINDOW"
	gb_ev_window_maximum_width: STRING = "Maximum Width"
	gb_ev_window_maximum_width_tooltip: STRING = "feature `maximum_width' from EV_WINDOW"
	gb_ev_window_maximum_height: STRING = "Maximum Height"
	gb_ev_window_maximum_height_tooltip: STRING = "feature `maximum_height' from EV_WINDOW"

	gb_ev_box_padding_width: STRING = "Padding Width"
	gb_ev_box_padding_width_tooltip: STRING = "feature `padding_width' from EV_BOX"
	gb_ev_box_border_width: STRING = "Border Width"
	gb_ev_box_border_width_tooltip: STRING = "feature `border_width' from EV_BOX"

	gb_ev_table_rows: STRING = "Rows"
	gb_ev_table_rows_tooltip: STRING = "feature `rows' from EV_TABLE"
	gb_ev_table_columns: STRING = "Columns"
	gb_ev_table_columns_tooltip: STRING = "feature `columns' from EV_TABLE"
	gb_ev_table_row_spacing: STRING = "Row Spacing"
	gb_ev_table_row_spacing_tooltip: STRING = "feature `row_spacing' from EV_TABLE"
	gb_ev_table_column_spacing: STRING = "Column Spacing"
	gb_ev_table_column_spacing_tooltip: STRING = "feature `column_spacing' from EV_TABLE"
	gb_ev_table_border_width: STRING = "Border Width"
	gb_ev_table_border_width_tooltip: STRING = "feature `border_width' from EV_TABLE"

	gb_ev_colorizable_foreground_color: STRING = "Foreground color"
	gb_ev_colorizable_foreground_color_tooltip: STRING = "feature `foreground_color' from GB_EV_COLORIZABLE"
	gb_ev_colorizable_background_color: STRING = "Background color"
	gb_ev_colorizable_background_color_tooltip: STRING = "feature `background_color' from GB_EV_COLORIZABLE"
	gb_ev_colorizable_restore_color: STRING = "Restore"
	background_color_restore: STRING = " Restore background color to default."
	foreground_color_restore: STRING = " Restore foreground color to default."

	gb_ev_deselectable_is_selected: STRING = "Is Selected?"
	gb_ev_deselectable_is_selected_tooltip: STRING = "feature `is_selected' from EV_SELECTABLE"

	gb_ev_sensitive_is_sensitive: STRING = "Is Sensitive?"
	gb_ev_sensitive_is_sensitive_tooltip: STRING = "feature `is_sensitive' from EV_SENSITIVE"

	gb_ev_tool_bar_has_vertical_button_style: STRING = "Vertical button style?"
	gb_ev_tool_bar_has_vertical_button_style_tooltip: STRING = "feature `has_vertical_button_style' from EV_TOOL_BAR"


	gb_ev_textable_text: STRING = "Text"
	gb_ev_textable_text_tooltip: STRING = "feature `text' from EV_TEXTABLE"

	gb_ev_text_alignable: STRING = "Text alignment"
	gb_ev_text_alignable_tooltip: STRING = "feature `text_alignment' from EV_TEXT_ALIGNABLE"

	gb_ev_tooltipable_tooltip: STRING = "Tooltip"
	gb_ev_tooltipable_tooltip_tooltip: STRING = "feature `tooltip' from EV_TOOLTIPABLE"

	gb_ev_pixmapable_pixmap: STRING = "Pixmap"
	gb_ev_pixmapable_pixmap_tooltip: STRING = "feature `pixmap' from EV_PIXMAPABLE"

	gb_ev_pixmap_pixmap: STRING = "Pixmap image"
	gb_ev_pixmap_pixmap_tooltip: STRING = "feature `set_with_named_file' from EV_PIXMAP"

	gb_ev_split_area_is_item_expanded_tooltip: STRING = "feature `is_item_expanded' from EV_SPLIT_AREA"

	gb_ev_container_radio_groups: STRING = "Merged radio groups"
	gb_ev_container_radio_groups_tooltip: STRING = "feature `merge_radio_groups' from EV_CONTAINER"
	gb_ev_container_propagate_foreground_color: STRING = "Propagate"
	gb_ev_container_propagate_foreground_color_tooltip: STRING = "Propagate foreground color to all children."
	gb_ev_container_propagate_background_color: STRING = "Propagate"
	gb_ev_container_propagate_background_color_tooltip: STRING = "Propagate background color to all children."

	gb_ev_text_component_is_editable: STRING = "Is editable?"
	gb_ev_text_component_is_editable_tooltip: STRING = "feature `is_editable' from EV_TEXT_COMPONENT"

	gb_ev_notebook_tab_position: STRING = "Tab Position"
	gb_ev_notebook_tab_position_tooltip: STRING = "feature `tab_position' from EV_NOTEBOOK"

	gb_ev_progress_bar_is_segmented: STRING = "Is segmented?"
	gb_ev_progress_bar_is_segmented_tooltip: STRING = "feature `is_segmented' from EV_PROGRESS_BAR"

	select_button_text: STRING = "Select..."
	set_with_named_file_tooltip: STRING = "Set pixmap image with named file"
	clear_text: STRING = "Clear"
	clear_tooltip: STRING = "Clear pixmap image"
	pixmap_missing_string: STRING = "Error - named pixmap missing."
	invalid_pixmap_contents_warning: STRING = " does not contain a valid image. Possible causes for this are:-%N%NFile is not one of the supported image types.%NFile is corrupted.%N%NPlease select a diferent file."

	select_constant_tooltip: STRING = "Select constant"

	object_editor_padding_width: INTEGER = 3

	object_editor_vertical_padding_width: INTEGER = 2

	reset_font_tooltip: STRING = "Restore default font"

	reset_background_color_tooltip: STRING = "Restore default background color"

	reset_foreground_color_tooltip: STRING = "Restore default foreground color"

	reset_minimum_width_tooltip: STRING = "Restore default minimum width"

	reset_minimum_height_tooltip: STRING = "Restore default minimum height"

	colorizable_type: STRING = "EV_COLORIZABLE"

feature -- Tooltips

	include_directory_button_tooltip: STRING = "Include all sub-directories"
		-- Tooltip for widget selector include directory button.

	show_hide_empty_directories_tooltip: STRING = "Show/Hide all empty directories"
		-- Tooltip for widget selector show hide empty directories button.

	new_directory_button_tooltip: STRING = "New directory"
		-- Tooltip for widget selector new directory button.

	expand_all_button_tooltip: STRING = "Expand all"
		-- Tooltip for widget selector expand all button.

feature -- Status texts

	directories_included_text: STRING = "All sub-directories included in project."

	all_empty_directories_shown_text: STRING = "All empty directories shown."

	all_empty_directories_hidden_text: STRING = "All empty directories hidden."

	all_expanded_text: STRING = "All nodes expanded."

feature -- Booleans

	multiple_line_entry: BOOLEAN = True
		-- Boolean value used to indicate that multiple line entry fields are required.

	single_line_entry: BOOLEAN = False
		-- Boolean value used to indicate that single line entry fields are required.

feature -- Constants

	Pixmap_constant_type: STRING = "PIXMAP"
		-- String representation of a pixmap constant.

	Integer_constant_type: STRING = "INTEGER"
		-- String representation of an integer constant.

	String_constant_type: STRING = "STRING"
		-- String representation of a string constant.

	directory_constant_type: STRING = "DIRECTORY"
		-- String representation of a directory constant.

	color_constant_type: STRING = "COLOR"
		-- String representation of a color constant.

	font_constant_type: STRING = "FONT"
		-- String representation of a font constant.

	filepath_constant_type: STRING = "FILEPATH"

	filename_constant_type: STRING = "FILENAME"

	all_constant_type: STRING = "ALL"
		-- String representation used to indicate all constant types.

	type_string: STRING = "type"
		-- String used to match type within XML.

	constant_name_string: STRING = "Name"
		-- Used to represent a constant name in XML

	constant_value_string: STRING = "Value"
		-- Used to represent a constant value in XML

	Constants_string: STRING = "Constants"
		-- String constant representing constants in XML.

	Constant_string: STRING = "Constant"
		-- String constant representing single constant in XML.

	is_absolute_string: STRING = "is_absolute"

	filename_string: STRING = "Filename"

	invalid_pixmap_name_prefix: STRING = "pixmap_"
		-- Name prepended to pixmaps that are invalid.

	integer_constant_set_procedures_string: STRING = "integer_constant_set_procedures"
	integer_constant_retrieval_functions_string: STRING = "integer_constant_retrieval_functions"
	string_constant_set_procedures_string: STRING = "string_constant_set_procedures"
	string_constant_retrieval_functions_string: STRING = "string_constant_retrieval_functions"
	font_constant_set_procedures_string: STRING = "font_constant_set_procedures"
	font_constant_retrieval_functions_string: STRING = "font_constant_retrieval_functions"
	color_constant_set_procedures_string: STRING = "color_constant_set_procedures"
	color_constant_retrieval_functions_string: STRING = "color_constant_retrieval_functions"
	pixmap_constant_set_procedures_string: STRING = "pixmap_constant_set_procedures"
	pixmap_constant_retrieval_functions_string: STRING = "pixmap_constant_retrieval_functions"
	integer_interval_constant_set_procedures_string: STRING = "integer_interval_constant_set_procedures"
	integer_interval_constant_retrieval_functions_string: STRING = "integer_interval_constant_retrieval_functions"

feature -- Preferences

	constants_do_not_show_again: STRING = "Reject invalid constants, and do not show this dialog again."

	delete_do_not_show_again: STRING = "Always delete via the keyboard, and do not show again."

	delete_warning1: STRING = "The currently selected "

	delete_warning2: STRING = " will be deleted.%N%NAre you sure you wish to perform this?"

feature -- Prompts

	select_directory_location_modify_string: STRING = "Please select new location for directory constant %""
		-- String displayed when selecting a new directroy during a modification of an existing directory constant.

	select_color_location_modify_string: STRING = "Please select new color value for color constant %""
		-- String displayed when selecting a new color during a modification of an existing color constant.

	select_font_location_modify_string: STRING = "Please select new font value for font constant %"";
		-- String displayed when selecting a new font during a modification of an existing font constant.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_CONSTANTS
