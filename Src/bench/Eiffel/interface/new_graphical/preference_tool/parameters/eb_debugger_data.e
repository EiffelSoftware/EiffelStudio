indexing
	description: "All user definable parameters for the debugger."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUGGER_DATA

inherit
	SHARED_RESOURCES

feature -- Access

	stack_element_width: INTEGER is
		do
			Result := integer_resource_value ("debugger__stack_element_width", 200)
		end

	show_text_in_project_toolbar: BOOLEAN is
			-- Show selected text in the project toolbar?
		do
			Result := boolean_resource_value ("debugger__show_text_in_project_toolbar", False)
		end

	display_dotnet_cmd: BOOLEAN is
			-- Should we display the .Net command? (ie is the user either Raphael or Karine?)
		do
			Result := boolean_resource_value ("display_dotnet_cmd", False)
		end
	
	retrieve_project_toolbar (command_pool: LIST [EB_TOOLBARABLE_COMMAND]): EB_TOOLBAR is
			-- Retreive the project toolbar using the available commands in `command_pool' 
		do
			Result := retrieve_toolbar (command_pool, project_toolbar_layout)
		end

	save_project_toolbar (project_toolbar: EB_TOOLBAR) is
			-- Save the project toolbar `project_toolbar' layout/status into the preferences.
			-- Call `save_resources' to have the changes actually saved.
		do
			set_array ("debugger__project_toolbar_layout", save_toolbar (project_toolbar))
			set_boolean ("debugger__show_text_in_project_toolbar", project_toolbar.is_text_displayed)
		end

feature {NONE} -- Implementation

	project_toolbar_layout: ARRAY [STRING] is
			-- Toolbar organization
		do
			Result := array_resource_value ("debugger__project_toolbar_layout", <<"Clear_bkpt__visible">>)
		end

	retrieve_toolbar (command_pool: LIST [EB_TOOLBARABLE_COMMAND]; layout: ARRAY [STRING]): EB_TOOLBAR is
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
				elseif command_name.is_equal (use_gray_icons_flag) then
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
							command_visibility := False
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
			if boolean_resource_value ("debugger__show_text_in_project_toolbar", False) then
				Result.enable_text_displayed
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
				Result.put (use_gray_icons_flag, index)
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

	Use_gray_icons_flag: STRING is "USE_GRAY_ICONS"
			-- What is written in the preferences to indicate that gray icons should or not be used.

end -- class EB_DEBUGGER_DATA
