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

	retrieve_toolbar_items (a_command_pool: LIST [EB_TOOLBARABLE_COMMAND]; a_layout: ARRAY [STRING_GENERAL]): ARRAYED_SET [SD_TOOL_BAR_ITEM] is
			-- Retriebe toolbar items.
		local
			l_i: INTEGER
			l_command_name: STRING_GENERAL
			l_command_visibility: BOOLEAN
			l_command_suffix: STRING_GENERAL
			l_command_name_count: INTEGER
			l_found: BOOLEAN
			l_button: SD_TOOL_BAR_BUTTON
			l_toolbarable_command: EB_TOOLBARABLE_COMMAND
			l_separator: SD_TOOL_BAR_SEPARATOR
			l_toolbarable_name: STRING_GENERAL
			l_separator_name: STRING_GENERAL
			l_added: ARRAYED_LIST [EB_TOOLBARABLE_COMMAND]
		do
			create Result.make (8)
			l_separator_name := (create {EB_TOOLBARABLE_SEPARATOR}).name
			create l_added.make (10)

			from
				l_i := a_layout.lower
			until
				l_i > a_layout.upper
			loop
				l_command_name := a_layout.item (l_i).twin
				l_command_name_count := l_command_name.count
				if l_command_name.is_equal (l_separator_name) then
						-- This is a separator.
					create l_separator.make
					Result.extend (l_separator)
				else
						-- This is a command.
					check
						command_name_not_void: l_command_name /= Void
						command_name_long_enough: l_command_name_count >= 9
							-- should be long enough to contain "__visible" or "__hidden"
					end
					l_command_suffix := l_command_name.substring (l_command_name_count - 8, l_command_name_count)
					if l_command_suffix.is_equal ("__visible") then
						l_command_visibility := True
						l_command_name := l_command_name.substring (1, l_command_name_count - 9)
					else
						l_command_suffix := l_command_name.substring (l_command_name_count - 7, l_command_name_count)
						if l_command_suffix.is_equal ("__hidden") then
							l_command_visibility := False
							l_command_name := l_command_name.substring (1, l_command_name_count - 8)
						else
							-- Error in suffix, it is not "__hidden" or "__visible", default is "__hidden".
							-- We leave the command_name inchanged.
							l_command_visibility := False
						end
					end
						-- Look for this command in the pool
					from
						a_command_pool.start
						l_found := False
					until
						l_found or a_command_pool.after
					loop
						l_toolbarable_command := a_command_pool.item
						l_toolbarable_name := l_toolbarable_command.name
						if l_toolbarable_name.is_equal (l_command_name) then
							l_found := True
								-- Add this command in the toolbar and set its visibility
							l_button := l_toolbarable_command.new_sd_toolbar_item (l_toolbarable_command.is_tooltext_important)
							if not l_toolbarable_command.is_sensitive then
								l_button.disable_sensitive
							end
							Result.extend (l_button)
							l_added.extend (l_toolbarable_command)
							if l_command_visibility then
								l_toolbarable_command.enable_displayed
								l_button.enable_displayed
							else
								l_toolbarable_command.disable_displayed
								l_button.disable_displayed
							end
						end
						a_command_pool.forth
					end
				end
					-- prepare next iteration
				l_i := l_i + 1
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
