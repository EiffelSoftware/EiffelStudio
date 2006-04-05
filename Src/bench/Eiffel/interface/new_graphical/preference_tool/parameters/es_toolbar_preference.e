indexing
	description: "Objects that manage customizable toolbars"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TOOLBAR_PREFERENCE

inherit
	ANY

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
				command_name := layout.item (i).twin
				command_name_count := command_name.count
				if command_name.is_equal (separator_name) then
						-- This is a separator.
					create toolbarable_separator
					Result.extend (toolbarable_separator)
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
			create Result.make (1, a_toolbar.count)
			from
				a_toolbar.start
			until
				a_toolbar.after
			loop
				toolbar_item := a_toolbar.item
				storage_name := toolbar_item.name.twin
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

indexing
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

end -- class ES_TOOLBAR_PREFERENCE
