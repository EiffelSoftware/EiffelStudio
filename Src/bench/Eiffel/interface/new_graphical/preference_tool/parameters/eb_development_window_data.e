indexing
	description	: "All shared attributes specific to the class tool"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DEVELOPMENT_WINDOW_DATA

inherit
	ES_TOOLBAR_PREFERENCE

create
	default_create

feature -- Access

	width: INTEGER is
			-- Width for the development window
		do
			Result := integer_resource_value ("development_window__width", 490)
		end

	height: INTEGER is
			-- Height for the development window
		do
			Result := integer_resource_value ("development_window__height", 500)
		end

	x_position: INTEGER is
			-- X position for development windows
		do
			Result := integer_resource_value ("development_window__x_position", 10)
		end

	y_position: INTEGER is
			-- Y position for development windows
		do
			Result := integer_resource_value ("development_window__y_position", 10)
		end

	is_maximized: BOOLEAN is
			-- Is the development window maximized?
		do
			Result := boolean_resource_value ("development_window__is_maximized", False)
		end

	left_panel_use_explorer_style: BOOLEAN is
			-- Should there be only one tool in the left panel?
		do
			Result := boolean_resource_value ("development_window__left_panel_use_explorer_style", True)
		end

	left_panel_width: INTEGER is
			-- Width for the left panel.
		do
			Result := integer_resource_value ("development_window__left_panel_width", 100)
		end

	left_panel_layout: ARRAY [STRING] is
			-- Layout of the left panel of the window.
		do
			Result := array_resource_value ("development_window__left_panel_layout", <<"visible","visible","visible">>)
		end

	right_panel_layout: ARRAY [STRING] is
			-- Layout of the left panel of the window.
		do
			Result := array_resource_value ("development_window__right_panel_layout", <<"visible", "visible">>)
		end

	show_general_toolbar: BOOLEAN is
			-- Show the general toolbar (New, Save, Cut, ...)?
		do
			Result := boolean_resource_value ("development_window__show_general_toolbar", True)
		end

	show_text_in_general_toolbar: BOOLEAN is
			-- Show selected text in the general toolbar?
		do
			Result := boolean_resource_value ("development_window__show_text_in_general_toolbar", False)
		end

	show_address_toolbar: BOOLEAN is
			-- Show the address toolbar (Back, Forward, Class, Feature, ...)?
		do
			Result := boolean_resource_value ("development_window__show_address_toolbar", True)
		end

	show_project_toolbar: BOOLEAN is
			-- Show the project toolbar (Breakpoints, ...)?
		do
			Result := boolean_resource_value ("development_window__show_project_toolbar", False)
		end

	context_unified_stone: BOOLEAN is
			-- Are the context tool and the development window sharing the same stone?
		do
			Result := boolean_resource_value ("unified_stone", False)
		end

	show_search_options: BOOLEAN is
			-- Are search tool options displayed ?
		do
			Result := boolean_resource_value ("search_tool__show_options", True)
		end
		

feature -- Element change

	save_size (a_width, a_height: INTEGER; a_maximized: BOOLEAN) is
			-- Save the width and the height of the window.
			-- Call `commit_save' to have the changes actually saved.
		do
			set_integer_resource ("development_window__width", a_width)
			set_integer_resource ("development_window__height", a_height)
			set_boolean_resource ("development_window__is_maximized", a_maximized)
		ensure
			width_set: a_width = width
			height_set: a_height = height
		end

	save_position (a_x, a_y: INTEGER) is
			-- Save the position of the window.
			-- Call `commit_save' to have the changes actually saved.
		do
			set_integer_resource ("development_window__x_position", a_x)
			set_integer_resource ("development_window__y_position", a_y)
		ensure
			x_set: a_x = x_position
			y_set: a_y = y_position
		end

	save_left_panel_width (a_width: INTEGER) is
			-- Save the width of the left panel of the window.
			-- Call `commit_save' to have the changes actually saved.
		do
			set_integer_resource ("development_window__left_panel_width", a_width)
		ensure
			width_set: a_width = left_panel_width
		end

	save_left_panel_layout (a_layout: ARRAY [STRING]) is
			-- Save the layout of the left panel of the window.
			-- Call `commit_save' to have the changes actually saved.
		do
			set_array_resource ("development_window__left_panel_layout", a_layout)
		end

	save_right_panel_layout (a_layout: ARRAY [STRING]) is
			-- Save the layout of the left panel of the window.
			-- Call `commit_save' to have the changes actually saved.
		do
			set_array_resource ("development_window__right_panel_layout", a_layout)
		end

	save_search_tool_options (search_tool: EB_SEARCH_TOOL) is
			-- 
		do
			set_boolean_resource ("search_tool__show_options", search_tool.options_shown)
		end
		
feature -- Basic operations

	retrieve_general_toolbar (command_pool: LIST [EB_TOOLBARABLE_COMMAND]): EB_TOOLBAR is
			-- Retreive the general toolbar using the available commands in `command_pool' 
		do
			Result := retrieve_toolbar (command_pool, general_toolbar_layout)
		end

feature {NONE} -- Implementation

	general_toolbar_layout: ARRAY [STRING] is
			-- Toolbar organization
		do
			Result := array_resource_value ("development_window__general_toolbar_layout", <<>>)
		end

end -- class EB_DEVELOPMENT_TOOL_DATA
