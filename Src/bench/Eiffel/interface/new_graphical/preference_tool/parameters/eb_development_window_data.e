indexing
	description	: "All shared attributes specific to the class tool"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DEVELOPMENT_WINDOW_DATA

inherit
	SHARED_RESOURCES

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
			set_integer ("development_window__width", a_width)
			set_integer ("development_window__height", a_height)
			set_boolean ("development_window__is_maximized", a_maximized)
		ensure
			width_set: a_width = width
			height_set: a_height = height
		end

	save_left_panel_width (a_width: INTEGER) is
			-- Save the width of the left panel of the window.
			-- Call `commit_save' to have the changes actually saved.
		do
			set_integer ("development_window__left_panel_width", a_width)
		ensure
			width_set: a_width = left_panel_width
		end

	save_left_panel_layout (a_layout: ARRAY [STRING]) is
			-- Save the layout of the left panel of the window.
			-- Call `commit_save' to have the changes actually saved.
		do
			set_array ("development_window__left_panel_layout", a_layout)
		end

	save_right_panel_layout (a_layout: ARRAY [STRING]) is
			-- Save the layout of the left panel of the window.
			-- Call `commit_save' to have the changes actually saved.
		do
			set_array ("development_window__right_panel_layout", a_layout)
		end

	save_search_tool_options (search_tool: EB_SEARCH_TOOL) is
			-- 
		do
			set_boolean ("search_tool__show_options", search_tool.options_shown)
		end
		
feature -- Basic operations

	retrieve_general_toolbar (command_pool: LIST [EB_TOOLBARABLE_COMMAND]): EB_TOOLBAR is
			-- Retreive the general toolbar using the available commands in `command_pool' 
		do
			Result := retrieve_toolbar (command_pool, general_toolbar_layout)
		end

	save_general_toolbar (general_toolbar: EB_TOOLBAR; is_visible: BOOLEAN) is
			-- Save the general toolbar `general_toolbar' layout/status into the preferences.
			-- Call `commit_save' to have the changes actually saved.
		do
			set_array ("development_window__general_toolbar_layout", save_toolbar (general_toolbar))
			set_boolean ("development_window__show_general_toolbar", is_visible)
			set_boolean ("development_window__show_text_in_general_toolbar", general_toolbar.is_text_displayed)
		end

feature {NONE} -- Implementation

	general_toolbar_layout: ARRAY [STRING] is
			-- Toolbar organization
		do
			Result := array_resource_value ("development_window__general_toolbar_layout", <<>>)
		end

	retrieve_toolbar (command_pool: LIST [EB_TOOLBARABLE_COMMAND]; layout: ARRAY [STRING]): EB_TOOLBAR is
			-- Rebuild a toolbar for a pool of commands and a layout.
		local
			i: INTEGER
			command_name: STRING
			command_visibility: BOOLEAN
			command_suffix: STRING
			command_name_count: INTEGER
			found: BOOLEAN
			toolbarable_command: EB_TOOLBARABLE_COMMAND
			toolbarable_separator: EB_TOOLBARABLE_SEPARATOR
			toolbarable_name: STRING
			separator_name: STRING
		do
			create Result
			separator_name := (create {EB_TOOLBARABLE_SEPARATOR}).name

			from
				i := layout.lower
			until
				i > layout.upper
			loop
				command_name := clone (layout @ i)
				command_name_count := command_name.count
				if command_name.is_equal (separator_name) then
						-- This is a separator.
					create toolbarable_separator
					Result.extend (toolbarable_separator)
				elseif command_name.is_equal (Use_gray_icons_flag) then
					Result.enable_gray_icons
				else
						-- This is a command.
					check
						command_name_not_void: command_name /= Void
						command_name_long_enough: command_name_count >= 9
							-- should be long enough to contain "__visible" or "__hidden"
					end
					command_suffix := command_name.substring (command_name_count - 8, command_name_count)
					if command_suffix.is_equal ("__visible") then
						command_visibility := True
						command_name := command_name.substring (1, command_name_count - 9)
					else
						command_suffix := command_name.substring (command_name_count - 7, command_name_count)
						if command_suffix.is_equal ("__hidden") then
							command_visibility := False
							command_name := command_name.substring (1, command_name_count - 8)
						else	
							-- Error in suffix, it is not "__hidden" or "__visible", default is "__hidden".
							-- We leave the command_name inchanged.
						end
					end

						-- Look for this command in the pool
					from
						command_pool.start
						found := False
					until
						found or command_pool.after
					loop
						toolbarable_command := command_pool.item
						toolbarable_name := toolbarable_command.name
						if toolbarable_name.is_equal (command_name) then
							found := True
								-- Add this command in the toolbar and set its visibility
							Result.extend (toolbarable_command)
							if command_visibility then
								toolbarable_command.enable_displayed
							else
								toolbarable_command.disable_displayed
							end
						end
						command_pool.forth
					end
				end
					
					-- prepare next iteration
				i := i + 1
			end						
		end

	save_toolbar (a_toolbar: EB_TOOLBAR): ARRAY [STRING] is
			-- Turn `a_toolbar' into a storable string.
		local
			storage_name: STRING
			toolbar_item: EB_TOOLBARABLE
			command: EB_TOOLBARABLE_COMMAND
			index: INTEGER
		do
			index := 1
			if a_toolbar.has_gray_icons then
				create Result.make (1, a_toolbar.count + 1)
				Result.put (Use_gray_icons_flag, index)
				index := index + 1
			else
				create Result.make (1, a_toolbar.count)
			end

			from
				a_toolbar.start
			until
				a_toolbar.after
			loop
				toolbar_item := a_toolbar.item
				storage_name := clone (toolbar_item.name)
				command ?= toolbar_item
				if command /= Void then
					if command.is_displayed then
						storage_name.append ("__visible")
					else
						storage_name.append ("__hidden")
					end
				end
				Result.put (storage_name, index)

					-- Prepare next iteration
				a_toolbar.forth
				index := index + 1
			end
		end

feature {NONE} -- Private constants

	Use_gray_icons_flag: STRING is "USE_GRAY_ICONS"

end -- class EB_DEVELOPMENT_TOOL_DATA
