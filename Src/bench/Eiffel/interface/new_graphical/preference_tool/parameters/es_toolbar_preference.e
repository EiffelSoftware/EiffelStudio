indexing
	description: "Objects that manage customizable toolbars"
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TOOLBAR_PREFERENCE

inherit
	SHARED_RESOURCES
		rename
			initialize as initialize_resources,
			initialized as resources_initialized
		export
			{NONE} all
		end

feature {NONE} -- Implementation

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

end -- class ES_TOOLBAR_PREFERENCE
