indexing
	description	: "All shared attributes specific to the development window."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DEVELOPMENT_WINDOW_DATA

inherit
	ES_TOOLBAR_PREFERENCE

create
	make

feature {EB_PREFERENCES} -- Initialization

	make (a_preferences: PREFERENCES) is
			-- Create
		require
			preferences_not_void: a_preferences /= Void
		do
			preferences := a_preferences
			initialize_preferences
		ensure
			preferences_not_void: preferences /= Void
		end	

feature {EB_SHARED_PREFERENCES} -- Value

	width: INTEGER is
			-- Width for the development window
		do
			Result := width_preference.value
		end

	height: INTEGER is
			-- Height for the development window
		do
			Result := height_preference.value
		end

	x_position: INTEGER is
			-- X position for development windows
		do
			Result := x_position_preference.value
		end

	y_position: INTEGER is
			-- Y position for development windows
		do
			Result := y_position_preference.value
		end

	is_maximized: BOOLEAN is
			-- Is the development window maximized?
		do
			Result := is_maximized_preference.value
		end

	left_panel_use_explorer_style: BOOLEAN is
			-- Should there be only one tool in the left panel?
		do
			Result := left_panel_use_explorer_style_preference.value
		end

	left_panel_width: INTEGER is
			-- Width for the left panel.
		do
			Result := left_panel_width_preference.value
		end

	left_panel_layout: ARRAY [STRING] is
			-- Layout of the left panel of the window.
		do
			Result := left_panel_layout_preference.value
		end

	right_panel_layout: ARRAY [STRING] is
			-- Layout of the left panel of the window.
		do
			Result := right_panel_layout_preference.value
		end

	show_general_toolbar: BOOLEAN is
			-- Show the general toolbar (New, Save, Cut, ...)?
		do
			Result := show_general_toolbar_preference.value 
		end

	show_text_in_general_toolbar: BOOLEAN is
			-- Show only selected text in the general toolbar?
		do
			Result := show_text_in_general_toolbar_preference.value
		end

	show_all_text_in_general_toolbar: BOOLEAN is
			-- Show all text in the general toolbar?
		do
			Result := show_all_text_in_general_toolbar_preference.value
		end

	show_address_toolbar: BOOLEAN is
			-- Show the address toolbar (Back, Forward, Class, Feature, ...)?
		do
			Result := show_address_toolbar_preference.value
		end

	show_project_toolbar: BOOLEAN is
			-- Show the project toolbar (Breakpoints, ...)?
		do
			Result := show_project_toolbar_preference.value
		end

	show_search_options: BOOLEAN is
			-- Are search tool options displayed ?
		do
			Result := show_search_options_preference.value
		end
		
	general_toolbar_layout: ARRAY [STRING] is
			-- Toolbar organization
		do
			Result := general_toolbar_layout_preference.value
		end
		
	max_history_size: INTEGER is
			-- Maximum number of items displayed in the history (in the address combo boxes).
		do
			Result := max_history_size_preference.value
		end
		
	use_animated_icons: BOOLEAN -- (True)	
	 
	remember_completion_list_size: BOOLEAN is
			-- 
		do
			Result := remember_completion_list_size_preference.value
		end
		
	completion_list_width: INTEGER is
			-- 
		do
			Result := completion_list_width_preference.value
		end
	
	completion_list_height: INTEGER is
			-- 
		do			
			Result := completion_list_height_preference.value
		end

	progress_bar_color: EV_COLOR is
			-- 
		do
			Result := progress_bar_color_preference.value	
		end
		
feature {EB_SHARED_PREFERENCES} -- Preference

	width_preference: INTEGER_PREFERENCE
			-- Width for the development window

	height_preference: INTEGER_PREFERENCE
			-- Height for the development window

	x_position_preference: INTEGER_PREFERENCE
			-- X position for development windows

	y_position_preference: INTEGER_PREFERENCE
			-- Y position for development windows

	is_maximized_preference: BOOLEAN_PREFERENCE
			-- Is the development window maximized?

	left_panel_use_explorer_style_preference: BOOLEAN_PREFERENCE
			-- Should there be only one tool in the left panel?

	left_panel_width_preference: INTEGER_PREFERENCE
			-- Width for the left panel.

	left_panel_layout_preference: ARRAY_PREFERENCE
			-- Layout of the left panel of the window.

	right_panel_layout_preference: ARRAY_PREFERENCE
			-- Layout of the left panel of the window.

	show_general_toolbar_preference: BOOLEAN_PREFERENCE
			-- Show the general toolbar (New, Save, Cut, ...)?

	show_text_in_general_toolbar_preference: BOOLEAN_PREFERENCE
			-- Show only selected text in the general toolbar?

	show_all_text_in_general_toolbar_preference: BOOLEAN_PREFERENCE
			-- Show all text in the general toolbar?

	show_address_toolbar_preference: BOOLEAN_PREFERENCE
			-- Show the address toolbar (Back, Forward, Class, Feature, ...)?

	show_project_toolbar_preference: BOOLEAN_PREFERENCE
			-- Show the project toolbar (Breakpoints, ...)?

	show_search_options_preference: BOOLEAN_PREFERENCE
			-- Are search tool options displayed ?
			
	general_toolbar_layout_preference: ARRAY_PREFERENCE
			-- 

	max_history_size_preference: INTEGER_PREFERENCE

	remember_completion_list_size_preference: BOOLEAN_PREFERENCE
		
	completion_list_width_preference: INTEGER_PREFERENCE
	
	completion_list_height_preference: INTEGER_PREFERENCE

	progress_bar_color_preference: COLOR_PREFERENCE

feature -- Element change

	save_size (a_width, a_height: INTEGER; a_maximized: BOOLEAN) is
			-- Save the width and the height of the window.
			-- Call `commit_save' to have the changes actually saved.
		do
			width_preference.set_value (a_width)
			height_preference.set_value (a_height)
			is_maximized_preference.set_value (a_maximized)
			preferences.save_resource (width_preference)
			preferences.save_resource (height_preference)
			preferences.save_resource (is_maximized_preference)
		ensure
			width_set: a_width = width
			height_set: a_height = height
		end

	save_position (a_x, a_y: INTEGER) is
			-- Save the position of the window.
			-- Call `commit_save' to have the changes actually saved.
		do
			x_position_preference.set_value (a_x)
			y_position_preference.set_value (a_y)
			preferences.save_resource (x_position_preference)
			preferences.save_resource (y_position_preference)
		ensure
			x_set: a_x = x_position
			y_set: a_y = y_position
		end

	save_left_panel_width (a_width: INTEGER) is
			-- Save the width of the left panel of the window.
			-- Call `commit_save' to have the changes actually saved.
		do
			left_panel_width_preference.set_value (a_width)
			preferences.save_resource (left_panel_width_preference)
		ensure
			width_set: a_width = left_panel_width
		end

	save_left_panel_layout (a_layout: ARRAY [STRING]) is
			-- Save the layout of the left panel of the window.
			-- Call `commit_save' to have the changes actually saved.
		do
			left_panel_layout_preference.set_value (a_layout)
			preferences.save_resource (left_panel_width_preference)
		end

	save_right_panel_layout (a_layout: ARRAY [STRING]) is
			-- Save the layout of the left panel of the window.
			-- Call `commit_save' to have the changes actually saved.
		do
			right_panel_layout_preference.set_value (a_layout)
			preferences.save_resource (right_panel_layout_preference)
		end

	save_search_tool_options (search_tool: EB_SEARCH_TOOL) is
			-- 
		do
			show_search_options_preference.set_value (search_tool.options_shown)
			preferences.save_resource (show_search_options_preference)
		end
		
	save_completion_list_size (a_width, a_height: INTEGER) is
			-- 
		do
			completion_list_width_preference.set_value (a_width)
			completion_list_height_preference.set_value (a_height)
			preferences.save_resource (completion_list_width_preference)
			preferences.save_resource (completion_list_height_preference)
		end		
		
feature -- Basic operations

	retrieve_general_toolbar (command_pool: LIST [EB_TOOLBARABLE_COMMAND]): EB_TOOLBAR is
			-- Retreive the general toolbar using the available commands in `command_pool' 
		do
			Result := retrieve_toolbar (command_pool, general_toolbar_layout)
		end

feature {NONE} -- Preference Strings

	width_string: STRING is "development_window.width"
	height_string: STRING is "development_window.height"
	x_position_string: STRING is "development_window.x_position"
	y_position_string: STRING is "development_window.y_position"
	is_maximized_string: STRING is "development_window.is_maximized"
	left_panel_use_explorer_style_string: STRING is "development_window.left_panel_use_explorer_style"
	left_panel_width_string: STRING is "development_window.window_left_panel_width"
	left_panel_layout_string: STRING is "development_window.left_panel_layout"
	right_panel_layout_string: STRING is "development_window.right_panel_layout"
	show_general_toolbar_string: STRING is "development_window.show_general_toolbar"
	show_text_in_general_toolbar_string: STRING is "development_window.show_text_in_general_toolbar"
	show_all_text_in_general_toolbar_string: STRING is "development_window.show_all_text_in_general_toolbar"
	show_address_toolbar_string: STRING is "development_window.show_address_toolbar"
	show_project_toolbar_string: STRING is "development_window.show_project_toolbar"
	search_tool_show_options_string: STRING is "development_window.search_tool_show_options"
	general_toolbar_layout_string: STRING is "development_window.general_toolbar_layout"
	max_history_size_string: STRING is "development_window.maximum_history_size"
	remember_completion_list_size_string: STRING is "development_window.remember_completion_list_size"
	completion_list_width_string: STRING is "development_window.completion_list_width"
	completion_list_height_string: STRING is "development_window.completion_list_height"
	progress_bar_color_preference_string: STRING is "misc.progress_bar_color"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER	
		do		
			create l_manager.make (preferences, "development_window")	
		
			width_preference := l_manager.new_integer_resource_value (l_manager, width_string, 490)
			height_preference := l_manager.new_integer_resource_value (l_manager, height_string, 500)
			x_position_preference := l_manager.new_integer_resource_value (l_manager, x_position_string, 10)
			y_position_preference := l_manager.new_integer_resource_value (l_manager, y_position_string, 10)
			is_maximized_preference := l_manager.new_boolean_resource_value (l_manager, is_maximized_string, False)
			left_panel_use_explorer_style_preference := l_manager.new_boolean_resource_value (l_manager, left_panel_use_explorer_style_string, True)
			left_panel_width_preference := l_manager.new_integer_resource_value (l_manager, left_panel_width_string, 100)
			left_panel_layout_preference := l_manager.new_array_resource_value (l_manager, left_panel_layout_string, <<"Features", "visible", "0", "0", "0", "100", "Clusters", "visible", "0", "0", "0", "100">>)
			right_panel_layout_preference := l_manager.new_array_resource_value (l_manager, right_panel_layout_string, <<"Editor", "visible", "0", "0", "0", "200", "Context", "visible", "0", "0", "0", "200">>)
			general_toolbar_layout_preference := l_manager.new_array_resource_value (l_manager, general_toolbar_layout_string, <<"New_window__visible;New_editor__hidden;New_context_window__hidden;Open_file__hidden;New_class__visible;New_feature__visible;Save_file__visible;Open_shell__visible;Separator;Undo__visible;Redo__visible;Separator;Editor_cut__visible;Editor_copy__visible;Editor_paste__visible;Separator;Clusters__visible;Features__visible;Search__visible;Context__visible;Separator;Send_to_context__visible;New_cluster__hidden;Remove_class_cluster__hidden;Favorites__hidden;Windows__hidden;Toggle_stone__hidden;Raise_all__hidden;Minimize_all__hidden;Print__hidden">>)
			show_general_toolbar_preference := l_manager.new_boolean_resource_value (l_manager, show_general_toolbar_string, True)
			show_text_in_general_toolbar_preference := l_manager.new_boolean_resource_value (l_manager, show_text_in_general_toolbar_string, False)
			show_all_text_in_general_toolbar_preference := l_manager.new_boolean_resource_value (l_manager, show_all_text_in_general_toolbar_string, False)
			show_address_toolbar_preference := l_manager.new_boolean_resource_value (l_manager, show_address_toolbar_string, True)
			show_project_toolbar_preference := l_manager.new_boolean_resource_value (l_manager, show_project_toolbar_string, False)			
			show_search_options_preference := l_manager.new_boolean_resource_value (l_manager, search_tool_show_options_string, True)	
			max_history_size_preference := l_manager.new_integer_resource_value (l_manager, max_history_size_string, 10)
			remember_completion_list_size_preference := l_manager.new_boolean_resource_value (l_manager, remember_completion_list_size_string, True)
			completion_list_height_preference := l_manager.new_integer_resource_value (l_manager, completion_list_height_string, 100)
			completion_list_width_preference := l_manager.new_integer_resource_value (l_manager, completion_list_width_string, 80)
			progress_bar_color_preference := l_manager.new_color_resource_value (l_manager, progress_bar_color_preference_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 128))
		end
	
	preferences: PREFERENCES
			-- Preferences

invariant
	preferences_not_void_not_void: preferences /= Void
	width_preference_not_void: width_preference /= Void
	height_preference_not_void: height_preference /= Void
	x_position_preference_not_void: x_position_preference /= Void
	y_position_preference_not_void: y_position_preference /= Void
	is_maximized_preference_not_void: is_maximized_preference /= Void
	left_panel_use_explorer_style_preference_not_void: left_panel_use_explorer_style_preference /= Void
	left_panel_width_preference_not_void: left_panel_width_preference /= Void
	left_panel_layout_preference_not_void: left_panel_layout_preference /= Void
	right_panel_layout_preference_not_void: right_panel_layout_preference /= Void
	show_general_toolbar_preference_not_void: show_general_toolbar_preference /= Void
	show_text_in_general_toolbar_preference_not_void: show_text_in_general_toolbar_preference /= Void
	show_all_text_in_general_toolbar_preference_not_void: show_all_text_in_general_toolbar_preference /= Void
	show_address_toolbar_preference_not_void: show_address_toolbar_preference /= Void
	show_project_toolbar_preference_not_void: show_project_toolbar_preference /= Void	
	show_search_options_preference_not_void: show_search_options_preference /= Void
	general_toolbar_layout_preference_not_void: general_toolbar_layout_preference /= Void
	max_history_size_preference_not_void: max_history_size_preference /= Void
	
end -- class EB_DEVELOPMENT_TOOL_DATA
